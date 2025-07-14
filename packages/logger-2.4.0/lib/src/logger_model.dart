

import 'package:logger/src/logger_list_class.dart';

class LoggerModel {
  final dynamic message;
  final DateTime? time;
  final Object? error;
  final StackTrace? stackTrace;
  final LogColor? color;

  LoggerModel({
    this.error,
    this.time,
    this.stackTrace,
    this.message,
    this.color,
  });
}
