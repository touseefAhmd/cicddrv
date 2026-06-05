import 'package:flutter/material.dart';

class ColorPalette {
  ColorPalette._();

  // -----------------------
  // Core Black & White (NEW)
  // -----------------------
  static const Color primaryBlack =  Colors.black54;
  static const Color primaryWhite = Colors.white60;

  static const Color black =  Colors.black;
  static const Color white = Colors.white;


  // -----------------------
  // Light Theme Surfaces
  // -----------------------
  static const Color lightScaffold = Color(0xFFE8EBEC);
  static const Color lightCard = Color(0xffedebeb);
  static const Color lightDrawer = primaryWhite;

  static const Color lightTextPrimary = Color(0xFF222A3D);
  static const Color lightTextSecondary = Color(0xFF4B5363);
  static const Color lightIconPrimary = Color(0xFF222A3D);
  static const Color lightBorder = Color(0xFFD1D5DB);

  // -----------------------
  // Dark Theme Surfaces
  // -----------------------
  static const Color darkScaffold = Color(0xff474749);
  static const Color darkCard = primaryBlack;
  static const Color darkDrawer = primaryBlack;

  static const Color darkTextPrimary = primaryWhite;
  static const Color darkTextSecondary = Color(0xFFB0B3C6);
  static const Color darkIconPrimary = primaryWhite;
  static const Color darkBorder = Color(0xFF3C3F55);

  // -----------------------
  // Brand Colors (unchanged)
  // -----------------------
  static const Color primary = Color(0xFF4B68FF);
  static const Color primaryLight = Color(0xFF6B82FF);
  // static const Color primaryDark = Color(0xFF2D4CCC);

  static const Color secondary = Color(0xFF6C63FF);
  static const Color secondaryDark = Color(0xFF3F38CC);

  // -----------------------
  // Semantic
  // -----------------------
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color red = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);


  // extra
  static const Color lightTextDisabled = Color(0xFFA1A5B8);
  static const Color greyLight = Color(0xFFD1D5DB);
  static const Color darkTextDisabled = Color(0xFF5A5E72);
  static const Color greyDark = Color(0xFF374151);
}



