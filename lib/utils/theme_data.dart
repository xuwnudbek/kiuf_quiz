import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomThemeData {
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
  );

  static ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(0xFF072e7e, {
      50: Color(0xFF072e7e),
      100: Color(0xFF072e7e),
      200: Color(0xFF072e7e),
      300: Color(0xFF072e7e),
      400: Color(0xFF072e7e),
      500: Color(0xFF072e7e),
      600: Color(0xFF072e7e),
      700: Color(0xFF072e7e),
      800: Color(0xFF072e7e),
      900: Color(0xFF072e7e),
    }),
  );

  //AppbarTheme
  static AppBarTheme appBarTheme = AppBarTheme(
    toolbarHeight: 70,
    backgroundColor: RGB.primary,
    foregroundColor: RGB.white,
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      // fontFamily: GoogleFonts.montserrat().fontFamily,
    ),
  );
}
