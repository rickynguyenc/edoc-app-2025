import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppGlobal {
  AppGlobal._();

  static AppGlobal? _instance;
  static AppGlobal get instance => _instance ??= AppGlobal._();

  late WidgetRef _ref;
  WidgetRef get ref => _ref;
  late BuildContext _context;
  BuildContext get context => _context;
  void init(WidgetRef ref, BuildContext context) {
    _context = context;
    _ref = ref;
  }
}
