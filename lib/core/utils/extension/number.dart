// ignore_for_file: unnecessary_this

import 'dart:math';

import 'package:intl/intl.dart';

import 'date_time.dart';

extension OnInt on int {
  String readTimestamp() {
    final date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return date.formatddMMYYYYHHmm();
  }

  String formatAmount() {
    final price = this.toString();
    var priceInText = '';
    var counter = 0;
    for (var i = (price.length - 1); i >= 0; i--) {
      counter++;
      final str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = '$str$priceInText';
      } else if (i == 0) {
        priceInText = '$str$priceInText';
      } else {
        priceInText = ',$str$priceInText';
      }
    }
    return priceInText.trim();
  }
}

extension DoubleFormat on double {
  String formatDouble() {
    final number = toStringAsFixed(2);
    final dotIndex = number.indexOf('.');
    var a = number.substring(0, dotIndex);
    final b = number.substring(dotIndex, number.length);

    var result = '';
    while (a.length > 3) {
      result = ',${a.substring(a.length - 3, a.length)}$result';
      a = a.substring(0, a.length - 3);
    }

    return a + result + b;
  }

  String formatAmount() {
    final inString = toStringAsFixed(2);
    final doubleStr = inString.split('.');
    final price = doubleStr[0];
    var priceInText = '';
    var counter = 0;
    for (var i = (price.length - 1); i >= 0; i--) {
      counter++;
      final str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = '$str$priceInText';
      } else if (i == 0) {
        priceInText = '$str$priceInText';
      } else {
        priceInText = ',$str$priceInText';
      }
    }
    if (doubleStr.length > 1 && doubleStr[1].isNotEmpty && doubleStr[1] != '00') {
      final lastStr = doubleStr[1].substring(max(doubleStr[1].length - 1, 0));
      // if (lastStr == '0') {
      //   return '${priceInText.trim()}.${doubleStr[1].replaceAll('0', '')}';
      // }
      return '${priceInText.trim()}.${doubleStr[1]}';
    }
    return priceInText.trim();
  }
}

extension NumFormat on num {
  String formatAmount() => this.toDouble().formatAmount();

  String formatNumber() {
    var textNumber = NumberFormat('##,###.##', 'en_US').format(this);

    if (this is double) {
      if (!textNumber.contains('.')) {
        textNumber += '.00';
      }
      if (textNumber.indexOf('.') == textNumber.length - 2) {
        textNumber += '0';
      }
    }
    return textNumber;
  }

  String formatToInt() {
    return NumberFormat('##,###', 'en_US').format(this);
  }
}
