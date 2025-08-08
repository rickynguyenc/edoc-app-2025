import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'env.dart';

class Utils {
  Utils._();

  static void log(param, [String? log]) {
    try {
      final msg = param is String ? param : json.encode(param);
      debugPrint('${log ?? ''} $msg');
    } catch (e) {
      debugPrint('[ERROR]: $e');
    }
  }

  static Flavor? get getFlavor => EnumToString.fromString(Flavor.values, const String.fromEnvironment('FLAVOR')); // check --dart-define=FLAVOR=development in makefile
}
