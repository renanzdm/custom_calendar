import 'package:flutter/material.dart';

const inicioDaSemana = DateTime.monday;
List<String> weeksName = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];

int diasDepoisDoUltimoDiaDoMes(DateTime lastDay) {
  int invertedStartingWeekday = 8 - inicioDaSemana;
  int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7);
  if (daysAfter == 7) {
    daysAfter = 0;
  }
  return daysAfter;
}

DateTimeRange criaDiasDoMes(DateTime focusedDay) {
  final primeiroDia = primeiroDiaDoMes(focusedDay);
  final diasAntes = diasAntesDoPrimeiroDiaDoMes(primeiroDia);
  final diaMesAnterior = primeiroDia.subtract(Duration(days: diasAntes));
  final ultimoDiaDoMes = pegaUltimoDiaDoMes(focusedDay);
  final diasDepois = diasDepoisDoUltimoDiaDoMes(ultimoDiaDoMes);
  final diaMesPosterior = ultimoDiaDoMes.add(Duration(days: diasDepois));

  return DateTimeRange(start: diaMesAnterior, end: diaMesPosterior);
}

DateTime pegaUltimoDiaDoMes(DateTime month) {
  final date = month.month < 12 ? DateTime.utc(month.year, month.month + 1, 1) : DateTime.utc(month.year + 1, 1, 1);
  return date.subtract(const Duration(days: 1));
}

int diasAntesDoPrimeiroDiaDoMes(DateTime firstDay) {
  return ((firstDay.weekday + 7) - inicioDaSemana) % 7;
}

DateTime primeiroDiaDaSemana(DateTime date) {
  final daysBefore = diasAntesDoPrimeiroDiaDoMes(date);
  var value = date.subtract(Duration(days: daysBefore));
  return value;
}

DateTime primeiroDiaDoMes(DateTime month) {
  return DateTime.utc(month.year, month.month, 1);
}

List<DateTime> criaOsDiasEmDelimatacoes(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) {
      return DateTime.utc(first.year, first.month, first.day + index);
    },
  );
}
