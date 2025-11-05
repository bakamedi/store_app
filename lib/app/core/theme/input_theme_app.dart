// Archivo: lib/core/themes/input_theme_app.dart

import 'package:flutter/material.dart';

class InputThemeApp {
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      // El campo de texto tendrá un fondo de color
      filled: true,
      fillColor: Colors.grey[300],
      // El padding interno del contenido
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      // El borde por defecto del campo de texto
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none, // Sin borde visible
      ),

      // El borde cuando el campo está enfocado
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey, width: 1.4),
      ),

      // El borde cuando el campo está habilitado, pero no enfocado
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),

      // Estilo del texto de sugerencia (hintText)
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),

      // Color para los íconos de prefijo y sufijo
      prefixIconColor: Colors.black,
      suffixIconColor: Colors.black,

      // El campo ocupará menos espacio vertical
      isDense: true,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.5),
      ),
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }
}
