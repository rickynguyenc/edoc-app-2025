import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(DateFormat format) {
    return format.format(this);
  }

  String formatYYYYMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formatddMMYYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String formatddMMyyyy() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String formatddMMYYYYHHmm() {
    return DateFormat('dd-MM-yyyy HH:mm').format(this);
  }

  int formatYYYYMMddHHNumber() {
    return int.parse(DateFormat('yyyyMMddHH').format(this));
  }
}
