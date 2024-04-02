import 'package:flutter/material.dart';

class CustomThemeData {
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
  );

  static ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  );
}
