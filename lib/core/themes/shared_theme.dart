import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

abstract class SharedTheme {
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(fontSize: 24),
    bodyMedium: TextStyle(fontSize: 16),
    displayLarge: TextStyle(fontSize: 28),
    bodyLarge: TextStyle(fontSize: 20),
    bodySmall: TextStyle(fontSize: 14),
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.withAlpha(128)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.withAlpha(128)),
    ),
    floatingLabelStyle: const TextStyle(fontSize: 14),
    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
  );
}
