import 'package:flutter/material.dart';

class TColors {
  TColors._(); // Prevent instantiation

  // =========================
  // Extended Colors Palette
  // =========================
  static const Color redLight = Color(0xFFFF6B6B);
  static const Color redDark = Color(0xFFB71C1C);
  static const Color greenLight = Color(0xFF81C784);
  static const Color greenDark = Color(0xFF2E7D32);
  static const Color blueLight = Color(0xFF64B5F6);
  static const Color blueDark = Color(0xFF0D47A1);
  static const Color purpleLight = Color(0xFFBA68C8);
  static const Color purpleDark = Color(0xFF6A1B9A);
  static const Color orangeLight = Color(0xFFFFB74D);
  static const Color orangeDark = Color(0xFFE65100);
  static const Color pinkLight = Color(0xFFF06292);
  static const Color pinkDark = Color(0xFFC2185B);
  static const Color cyanLight = Color(0xFF4DD0E1);
  static const Color cyanDark = Color(0xFF006064);
  static const Color tealLight = Color(0xFF4DB6AC);
  static const Color tealDark = Color(0xFF004D40);
  static const Color amberLight = Color(0xFFFFE082);
  static const Color amberDark = Color(0xFFFF8F00);
  static const Color brownLight = Color(0xFFA1887F);
  static const Color brownDark = Color(0xFF4E342E);
  static const Color accent = Color(0xFFFFC400);        // Yellow / Highlight
  static const Color success = Color(0xFF28A745);       // Green
  static const Color warning = Color(0xFFFFC107);       // Orange-Yellow
  static const Color error = Color(0xFFDC3545);         // Red
  static const Color info = Color(0xFF17A2B8);          // Sky Blue

  // =========================
  // Core Brand Colors
  // =========================
  static const Color primary = Color(0xFF4B68FF);       // Blue
  static const Color primaryLight = Color(0xFF6B82FF);
  static const Color primaryDark = Color(0xFF2D4CCC);

  static const Color secondary = Color(0xFF6C63FF);     // Purple
  static const Color secondaryLight = Color(0xFF9A92FF);
  static const Color secondaryDark = Color(0xFF3F38CC);


  // =========================
  // Neutral Shades
  // =========================
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color greyLight = Color(0xFFD1D5DB);
  static const Color greyMedium = Color(0xFF6B7280);
  static const Color greyDark = Color(0xFF374151);
  static const Color softGrey = Color(0xFFF3F4F6);

  // =========================
  // Light Theme Colors
  // =========================
  static const Color lightScaffold = Color(0xFFF9FAFB);
  static const Color lightAppBar = primary;
  static const Color lightDrawer = Colors.white;
  static const Color lightContainer = Colors.white;
  static const Color lightCard = softGrey;

  static const Color lightTextPrimary = Color(0xFF222A3D);
  static const Color lightTextSecondary = Color(0xFF4B5363);
  static const Color lightTextDisabled = Color(0xFFA1A5B8);
  static const Color lightIconPrimary = Color(0xFF222A3D);

  static const Color lightBorder = Color(0xFFD1D5DB);

  // =========================
  // Dark Theme Colors
  // =========================
  static const Color darkScaffold = Color(0xFF13172A);
  static const Color darkAppBar = primaryDark;
  static const Color darkDrawer = secondaryDark;
  static const Color darkContainer = Color(0xFF1E1E2F);
  static const Color darkCard = Color(0xFF1E1E2F);

  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB0B3C6);
  static const Color darkTextDisabled = Color(0xFF5A5E72);
  static const Color darkIconPrimary = Colors.white;

  static const Color darkBorder = Color(0xFF3C3F55);

  // =========================
  // Component Specific Colors
  // =========================

  // AppBar
  static const Color appBarLightBackground = primary;
  static const Color appBarDarkBackground = primaryDark;
  static const Color appBarLightText = lightTextPrimary;
  static const Color appBarDarkText = darkTextPrimary;

  // Drawer
  static const Color drawerLightBackground = lightDrawer;
  static const Color drawerDarkBackground = darkDrawer;
  static const Color drawerLightText = lightTextPrimary;
  static const Color drawerDarkText = darkTextPrimary;

  // Buttons
  static const Color buttonLightPrimary = primary;
  static const Color buttonDarkPrimary = primaryDark;
  static const Color buttonLightSecondary = secondary;
  static const Color buttonDarkSecondary = secondaryDark;

  // Icons
  static const Color iconLightPrimary = lightIconPrimary;
  static const Color iconDarkPrimary = darkIconPrimary;

  // Containers / Cards
  static const Color containerLight = lightContainer;
  static const Color containerDark = darkContainer;
  static const Color cardLight = lightCard;
  static const Color cardDark = darkCard;
}
