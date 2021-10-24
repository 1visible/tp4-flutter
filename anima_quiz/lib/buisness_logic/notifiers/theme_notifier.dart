import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;

  bool getThemeMode() {
    final systemMode = SchedulerBinding.instance!.window.platformBrightness;
    return (mode == ThemeMode.system && systemMode == Brightness.dark) ||
        mode == ThemeMode.dark;
  }

  void setThemeMode(bool dark) {
    mode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
