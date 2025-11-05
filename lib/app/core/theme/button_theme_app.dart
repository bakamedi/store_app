import 'package:flutter/material.dart';

class ButtonThemeApp {
  static OutlinedButtonThemeData outlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, 50),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black.withValues(alpha: 0.2);
          }
          return null;
        }),
        iconColor: WidgetStateProperty.resolveWith<Color>((states) {
          return Colors.white;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: Colors.black, width: 2),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, 50),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          return Colors.black;
        }),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return Colors.black.withAlpha((0.1 * 255).round());
          }
          return null;
        }),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 14),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        iconColor: WidgetStateProperty.resolveWith<Color>((states) {
          return Colors.white;
        }),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          return const TextStyle(fontWeight: FontWeight.w700);
        }),
      ),
    );
  }
}
