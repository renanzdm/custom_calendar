import 'package:custom_calendar/utils.dart';
import 'package:flutter/material.dart';

import 'custom_calendar_controller.dart';

class CustomCalendarBase extends StatefulWidget {
  const CustomCalendarBase({Key? key}) : super(key: key);

  @override
  State<CustomCalendarBase> createState() => _CustomCalendarBaseState();
}

class _CustomCalendarBaseState extends State<CustomCalendarBase> {
  CustomCalendarController controller = CustomCalendarController.singleton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
            valueListenable: controller.date,
            builder: (context, value, child) {
              return HeaderCalendar(
                monthName: '${_monthName(value.month)} ${value.year}',
                nextMonth: () {
                  int month = value.month;
                  month++;
                  controller.date.value = DateTime(value.year, month);
                },
                previousMonth: () {
                  int month = value.month;
                  month--;
                  controller.date.value = DateTime(value.year, month);
                },
              );
            }),
        SizedBox(
          width: 500.0,
          height: 500.0,
          child: ValueListenableBuilder<DateTime>(
              valueListenable: controller.date,
              builder: (context, snapshot, child) {
                final DateTimeRange dateTimeRange = criaDiasDoMes(snapshot);
                return Table(
                  children: [
                    _criaNomeDiasDaSemana(),
                    ..._criaWidgetDiasDoMes(criaOsDiasEmDelimatacoes(dateTimeRange.start, dateTimeRange.end)),
                  ],
                );
              }),
        ),
      ],
    );
  }
}

List<TableRow> _criaWidgetDiasDoMes(List<DateTime> dates) {
  final weeksQtd = dates.length ~/ 7;
  return List.generate(weeksQtd, (index) => index * 7)
      .map((week) => TableRow(
            children: List.generate(
              7,
              (day) => Text(dates[week + day].day.toString()),
            ),
          ))
      .toList();
}

String _monthName(int index) {
  switch (index) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
    default:
      return '';
  }
}

TableRow _criaNomeDiasDaSemana() {
  reorderDaysWeek();
  return TableRow(
    children: List.generate(7, (index) {
      return Text(weeksName[index]);
    }).toList(),
  );
}

void reorderDaysWeek() {
  List<String> names = weeksName.sublist(inicioDaSemana - 1, weeksName.length);
  weeksName.removeRange(inicioDaSemana - 1, weeksName.length);
  weeksName.insertAll(0, names);
}

class HeaderCalendar extends StatelessWidget {
  const HeaderCalendar({Key? key, required this.monthName, required this.nextMonth, required this.previousMonth}) : super(key: key);
  final VoidCallback previousMonth;
  final VoidCallback nextMonth;

  final String monthName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: previousMonth, icon: const Icon(Icons.arrow_back_ios)),
        Expanded(
            child: Text(
          monthName,
          textAlign: TextAlign.center,
        )),
        IconButton(onPressed: nextMonth, icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
