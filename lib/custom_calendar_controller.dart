import 'package:flutter/foundation.dart';

class CustomCalendarController {
  CustomCalendarController._();
  static CustomCalendarController? _instance;
  static CustomCalendarController get singleton => _instance ??= CustomCalendarController._();

  int initialMonth = DateTime.now().month;
  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
}
