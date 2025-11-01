import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constants.dart';
import '../services/prefs.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void getCurrentTheme() {
    bool isDark = Prefs.getBool(kIsDarkMode);
    if (isDark) {
      emit(darkTheme);
    } else {
      emit(lightTheme);
    }
  }

  void toggleTheme() {
    Prefs.setBool(kIsDarkMode, !Prefs.getBool(kIsDarkMode));
    getCurrentTheme();
  }
}
