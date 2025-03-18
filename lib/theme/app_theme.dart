// theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF36D1B6);
  static const Color backgroundColor = Color(0xFF1D1D3B);
  static const Color cardColor = Color(0xFF495888);
  static const Color highRiskColor = Color(0xFFFF5D8F);
  static const Color mediumRiskColor = Color(0xFFF4F4A9);
  static const Color lowRiskColor = Color(0xFF4FECB8);
  static const Color textColor = Colors.white;
  static const Color accentColor = Color(0xFFFFD74A);

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: cardColor,
      background: backgroundColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 2.0,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
    ),
    fontFamily: 'Poppins',
  );
}