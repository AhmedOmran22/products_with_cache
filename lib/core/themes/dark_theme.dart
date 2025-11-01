import 'package:cache_and_theme_task_mentorship/core/themes/shared_theme.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  splashFactory: NoSplash.splashFactory,
  colorScheme: const ColorScheme.dark(primary: AppColors.primaryColor),
  brightness: Brightness.dark,
  useMaterial3: true,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.grey,
    ),
  ),
  textTheme: SharedTheme.textTheme,
  bottomNavigationBarTheme: darkBottomNavigationBarTheme,
);
BottomNavigationBarThemeData darkBottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      type: BottomNavigationBarType.fixed,
    );
