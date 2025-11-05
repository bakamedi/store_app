// ignore_for_file: avoid-unused-parameters

import 'package:flutter/material.dart';

class ThemeApp {
  // Singleton
  factory ThemeApp() => _instance;
  const ThemeApp._();
  static final ThemeApp _instance = const ThemeApp._();

  static ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: Colors.black,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.black.withValues(alpha: 0.5),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get theme => _buildTheme();
}
