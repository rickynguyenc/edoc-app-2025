import 'package:intl/intl.dart';

extension StringToDateTime on String {
  //2020-02-27T15:11:03.153
  DateTime convertToDateTime({String format = 'yyyy-MM-ddTHH:mm:ss'}) {
    final stringToDateTime = DateFormat(format);
    return stringToDateTime.parse(this);
  }

  DateTime convertDDMMYYYYToDateTime() {
    final stringToDateTime = DateFormat('dd/MM/yyyy');
    return stringToDateTime.parse(this);
  }
}
