import 'package:driver_app/utils/theme/text_theme.dart';
import 'package:driver_app/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../color_patette.dart';


class AppTheme {
  AppTheme._(); // Prevent instantiation

  //#region ------------------------ Helper to check dark mode ------------------------
  static bool _isDark(BuildContext context) => context.watch<ThemeProvider>().isDark;
  //#endregion ------------------------ Helper to check dark mode ------------------------

  //#region ------------------------ Size ------------------------
  static const double headerFontSize = 18;
  static const double labelFontSize = 16;
  static const double valueFontSize = 14;
  //#endregion ------------------------ Size ------------------------

  //#region ------------------------ Font Family ------------------------
  static const String headerFontFamily = 'Poppins';
  static const String primaryFontFamily = 'Inter';
//#endregion ------------------------ Font Family ------------------------

  //#region ------------------------ Colors ------------------------
  static Color get darkColor => ColorPalette.darkScaffold;
  static Color get lightColor => ColorPalette.lightScaffold;
  //#endregion ------------------------ Colors ------------------------

  //#region ------------------------ Scaffold background ------------------------
  static Color scaffoldBackground(BuildContext context) => _isDark(context) ? darkColor : lightColor;
  //#endregion ------------------------ Scaffold background ------------------------

  //#region ------------------------ AppBar ------------------------
  static Color appBarBackground(BuildContext context) => _isDark(context) ? darkColor : lightColor;

  static Color appBarIconColor(BuildContext context) =>  _isDark(context) ? ColorPalette.primaryWhite : ColorPalette.primaryBlack;

  static TextStyle appBarTitleTextStyle(BuildContext context) => (_isDark(context) ? TextThemes.dark : TextThemes.light).titleMedium!;
  //#endregion ------------------------ AppBar ------------------------

  //#region ------------------------ Drawer ------------------------
  static Color drawerBackground(BuildContext context) => _isDark(context) ? darkColor : lightColor;

  static Color drawerUserNameColor(BuildContext context) => valueColor(context);

  static Color drawerUserLabelColor(BuildContext context) => labelColor(context);

  static Color drawerItemColor(BuildContext context) => cardBackgroundColor(context);

  static Color drawerItemHoverColor(BuildContext context) => drawerBackground(context);

  static Color drawerItemIconColor(BuildContext context) => valueColor(context);

  static Color drawerDividerColor(BuildContext context) => drawerBackground(context);
  //#endregion ------------------------ Drawer ------------------------

  //#region ------------------------ Card ------------------------
  static Color cardBackgroundColor(BuildContext context) => _isDark(context) ? ColorPalette.primaryBlack : ColorPalette.primaryWhite;

  static Color cardHoverBorderColor(BuildContext context) => _isDark(context) ? ColorPalette.primaryWhite.withValues(alpha: 0.4) : ColorPalette.primaryBlack.withValues(alpha: 0.3);

  static List<BoxShadow> cardShadow(BuildContext context) {
    final isDarkMode = _isDark(context);

    return [
      BoxShadow(
        color: Colors.white.withValues(alpha: isDarkMode ? 0.02 : null),
        offset: isDarkMode ? Offset(-5, -5) : Offset(-10, -10),
        blurRadius: isDarkMode ? 4 : 20,
      ),
      BoxShadow(
        color: isDarkMode ? ColorPalette.primaryWhite.withValues(alpha: 0.02) : Colors.black.withOpacity(0.15),
        offset: isDarkMode ? Offset(5, 5) : Offset(10, 10),
        blurRadius: isDarkMode ? 4 : 20,
      ),
    ];
  }
  //#endregion ------------------------ Card ------------------------

  //#region ------------------------ Text Styles ------------------------
  static Color valueColor(BuildContext context) => _isDark(context) ? ColorPalette.primaryWhite : ColorPalette.primaryBlack;

  static Color labelColor(BuildContext context) => _isDark(context) ? ColorPalette.darkTextSecondary : ColorPalette.greyDark;

  static Color headerColor(BuildContext context) => _isDark(context) ? ColorPalette.darkTextPrimary : ColorPalette.lightTextPrimary;

  static TextStyle labelStyle(BuildContext context) => TextStyle(
    fontSize: labelFontSize,
    fontWeight: FontWeight.bold,
    fontFamily: primaryFontFamily,
    color: labelColor(context),
  );

  static TextStyle valueStyle(BuildContext context) => TextStyle(
    fontSize: valueFontSize,
    fontFamily: primaryFontFamily,
    color: valueColor(context),
  );

  static TextStyle headerStyle(BuildContext context) => TextStyle(
    fontSize: headerFontSize,
    fontWeight: FontWeight.bold,
    fontFamily: headerFontFamily,
    color: headerColor(context),
  );
  //#endregion ------------------------ Text Styles ------------------------

  //#region ------------------------ Primary Color setter ------------------------
  static Color primaryColorsValue(BuildContext context) => _isDark(context) ? ColorPalette.primary : ColorPalette.primaryLight;

  //#endregion ------------------------ Primary Color setter ------------------------


  //#region ------------------------ Button ------------------------
  static Color elevatedButtonForeground(BuildContext context) => _isDark(context) ? Colors.red : Colors.white;
  static Color elevatedButtonBackground(BuildContext context) => _isDark(context) ? Colors.white : Colors.blueAccent;
  //#endregion ------------------------ Button ------------------------

//#region ------------------------ Borders ------------------------
  static BorderRadius textFieldBorderRadius = BorderRadius.circular(8);

  static InputBorder primaryBorder(BuildContext context) => OutlineInputBorder(
      borderRadius: textFieldBorderRadius,
      borderSide: BorderSide(width: 1.0, color: AppTheme.cardBackgroundColor(context))
  );
  static InputBorder enableBorder(BuildContext context) => OutlineInputBorder(
      borderRadius: textFieldBorderRadius,
      borderSide: BorderSide(width: 1.0, color: AppTheme.cardBackgroundColor(context))
  );
  static InputBorder focusBorder(BuildContext context) => OutlineInputBorder(
      borderRadius: textFieldBorderRadius,
      borderSide: BorderSide(width: 1.0, color: AppTheme.cardHoverBorderColor(context))
  );
//#endregion ------------------------ Borders ------------------------

//#region ------------------------ Tabs ------------------------
  static Color tabsSelectedColor(BuildContext context) =>  _isDark(context) ? ColorPalette.white : ColorPalette.black;
//#endregion ------------------------ Tabs ------------------------
}
