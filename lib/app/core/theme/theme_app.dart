// ignore_for_file: avoid-unused-parameters

import 'package:flutter/material.dart';
import 'package:store_app/app/core/theme/appbar_theme_app.dart';
import 'package:store_app/app/core/theme/button_theme_app.dart';
import 'package:store_app/app/core/theme/floating_action_button_theme_app.dart';
import 'package:store_app/app/core/theme/input_theme_app.dart';

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
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputThemeApp.inputDecorationTheme(),
      outlinedButtonTheme: ButtonThemeApp.outlinedButtonThemeData(),
      elevatedButtonTheme: ButtonThemeApp.elevatedButtonThemeData(),
      floatingActionButtonTheme:
          FloatingActionButtonThemeApp.floatingActionButtonThemeData(),
      appBarTheme: AppbarThemeApp.appBarTheme(),
    );
  }

  static ThemeData get theme => _buildTheme();
}
