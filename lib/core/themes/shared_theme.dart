import 'package:flutter/material.dart';

abstract class SharedTheme {
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(fontSize: 24),
    bodyMedium: TextStyle(fontSize: 16),
    displayLarge: TextStyle(fontSize: 28),
    bodyLarge: TextStyle(fontSize: 20),
    bodySmall: TextStyle(fontSize: 14),
  );
}
