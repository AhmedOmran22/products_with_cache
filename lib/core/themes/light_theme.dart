import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'shared_theme.dart';

ThemeData lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.whiteColor,
  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
  brightness: Brightness.light,

  useMaterial3: true,
  inputDecorationTheme: SharedTheme.inputDecorationTheme,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.grey,
    ),
  ),
  textTheme: SharedTheme.textTheme,
  bottomNavigationBarTheme: lightBottomNavigationBarTheme,
);

BottomNavigationBarThemeData lightBottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      type: BottomNavigationBarType.fixed,
    );
