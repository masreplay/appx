import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format() {
    var inputFormat = DateFormat('MM/dd/yyyy HH:mm');
    return inputFormat.format(this);
  }

  String formatDate() {
    var inputFormat = DateFormat('MM/dd/yyyy');
    return inputFormat.format(this);
  }
}

extension NullableDateTimeExtension on DateTime? {
  String formatDate() {
    var inputFormat = DateFormat('MM/dd/yyyy');

    return this == null ? "" : inputFormat.format(this!);
  }
}
