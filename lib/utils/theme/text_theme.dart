import 'package:flutter/material.dart';
import '../color_patette.dart';

class TextThemes {
  TextThemes._(); // Prevent instantiation

  // ------------------------
  // Light Theme Text
  // ------------------------
  static final TextTheme light = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: ColorPalette.lightTextPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: ColorPalette.lightTextPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: ColorPalette.lightTextPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ColorPalette.lightTextPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorPalette.lightTextSecondary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: ColorPalette.lightTextSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: ColorPalette.lightTextDisabled,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: ColorPalette.lightTextPrimary,
    ),
  );

  // ------------------------
  // Dark Theme Text
  // ------------------------
  static final TextTheme dark = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: ColorPalette.darkTextPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: ColorPalette.darkTextPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: ColorPalette.darkTextPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ColorPalette.darkTextPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorPalette.darkTextSecondary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: ColorPalette.darkTextSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: ColorPalette.darkTextDisabled,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: ColorPalette.darkTextPrimary,
    ),
  );
}
