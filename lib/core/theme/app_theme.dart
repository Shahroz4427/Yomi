import 'package:flutter/material.dart';

class AppTheme {
  // App colors
  static const Color backgroundColor = Color(0xFF09090F);
  static const Color surfaceColor = Color(0xFF15151F);
  static const Color primaryColor = Color(0xFF7965E8);
  static const Color secondaryColor = Color(0xFFA18BFF);
  static const Color primaryTextColor = Color(0xFFF5F4FA);
  static const Color secondaryTextColor = Color(0xFF9694A8);
  static const Color borderColor = Color(0xFF292837);
  static const Color accentColor = Color(0xFF7965E8);

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: backgroundColor,

      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,

      ),

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: primaryTextColor,
        elevation: 0,
        centerTitle: false,
      ),

      // Text styles
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: primaryTextColor),
        bodyMedium: TextStyle(color: secondaryTextColor),
        bodySmall: TextStyle(color: secondaryTextColor, fontSize: 11),
      ),

      // Cards
      cardTheme: const CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: borderColor, width: 0.7),
        ),
      ),

      // Primary buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // Outlined buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryTextColor,
          side: const BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: const TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),

      dividerColor: borderColor,
    );
  }
}
