import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

enum SnackBarType { info, success, warning, error, custom, toast, heart, star }

class HSnackBar {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  //static bool get isDark => THelperFunctions.isDarkMode(Get.context!);
  static bool get isDark => false;

  //#region custom SnackBar
  static customSnackBar({
    SnackBarType? type,
    String title = '',
    required String message,
    int duration = 3,
    IconData? icon,
    Color? backgroundColor,
    Color? titleColor,
    Color? messageColor,
  }) {
    if (type == SnackBarType.toast) {
      customToast(message: message, duration: duration);
    } else {
      // Default values
      String defaultTitle;
      IconData defaultIcon;
      Color defaultBackgroundColor;
      Color defaultTitleColor = Colors.white;
      Color defaultMessageColor = Colors.white;

      // Determine defaults based on type
      if (type == SnackBarType.success) {
        defaultTitle = title.isNotEmpty ? title : 'Success';
        defaultIcon = icon ?? Icons.check;
        defaultBackgroundColor = backgroundColor ?? TColors.greenLight;
        defaultTitleColor = titleColor ?? TColors.greenDark;
        defaultMessageColor = messageColor ?? TColors.white;
      } else if (type == SnackBarType.error) {
        defaultTitle = title.isNotEmpty ? title : 'Error';
        defaultIcon = icon ?? Icons.circle;
        defaultBackgroundColor = backgroundColor ?? TColors.redLight;
        defaultTitleColor = titleColor ?? TColors.redDark;
        defaultMessageColor = messageColor ?? TColors.white;
      } else if (type == SnackBarType.warning) {
        defaultTitle = title.isNotEmpty ? title : 'Warning';
        defaultIcon = icon ?? Icons.warning;
        defaultBackgroundColor = backgroundColor ?? TColors.orangeLight;
        defaultTitleColor = titleColor ?? TColors.orangeDark;
        defaultMessageColor = messageColor ?? TColors.black;
      } else if (type == SnackBarType.info) {
        defaultTitle = title.isNotEmpty ? title : 'Info';
        defaultIcon = icon ?? Icons.info;
        defaultBackgroundColor = backgroundColor ?? TColors.blueLight;
        defaultTitleColor = titleColor ?? TColors.blueDark;
        defaultMessageColor = messageColor ?? TColors.white;
      } else if (type == SnackBarType.star) {
        defaultTitle = title.isNotEmpty ? title : 'Star';
        defaultIcon = icon ?? Icons.star;
        defaultBackgroundColor = backgroundColor ?? Colors.purple.shade600;
        defaultTitleColor = titleColor ?? Colors.purpleAccent;
        defaultMessageColor = messageColor ?? TColors.white;
      } else if (type == SnackBarType.heart) {
        defaultTitle = title.isNotEmpty ? title : 'Heart';
        defaultIcon = icon ?? Icons.monitor_heart_outlined;
        defaultBackgroundColor = backgroundColor ?? TColors.pinkLight;
        defaultTitleColor = titleColor ?? TColors.pinkDark;
        defaultMessageColor = messageColor ?? TColors.black;
      } else {
        // fallback
        defaultTitle = title.isNotEmpty ? title : '';
        defaultIcon = icon ?? Icons.circle;
        defaultBackgroundColor = backgroundColor ?? TColors.cyanLight;
        defaultTitleColor = titleColor ?? TColors.cyanDark;
        defaultMessageColor = messageColor ?? TColors.white;
      }

      // Show the snack bar
      Get.snackbar(
        defaultTitle,
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.all(16),
        isDismissible: true,
        shouldIconPulse: true,
        backgroundColor: defaultBackgroundColor,
        colorText: defaultMessageColor,
        icon: Icon(defaultIcon, color: defaultMessageColor),
        titleText: Text(defaultTitle, style: TextStyle(color: defaultTitleColor, fontWeight: FontWeight.bold)),
        messageText: Text(message, style: TextStyle(color: defaultMessageColor)),
      );
    }
  }

  //#endregion

  //#region Success SnackBar
  static successSnackBar({required String message, int duration = 3}) {
    customSnackBar(
      type: SnackBarType.success,
      message: message,
      duration: duration,
    );
  }

  //#endregion

  //#region Error SnackBar
  static errorSnackBar({required String message, int duration = 3}) {
    customSnackBar(
      type: SnackBarType.error,
      message: message,
      duration: duration,
    );
  }
  //#endregion

  //#region Warning SnackBar
  static warningSnackBar({required String message, int duration = 3}) {
    customSnackBar(
      type: SnackBarType.warning,
      message: message,
      duration: duration,
    );
  }
  //#endregion

  //#region Info SnackBar
  static infoSnackBar({required String message, int duration = 3}) {
    customSnackBar(
      type: SnackBarType.info,
      message: message,
      duration: duration,
    );
  }
  //#endregion

  //#region Custom Toast
  static customToast({required String message, int duration = 3}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(seconds: duration),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isDark ? TColors.primaryLight: TColors.primaryLight,
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(color: isDark ? TColors.white : TColors.white),
            ),
          ),
        ),
      ),
    );
  }
//#endregion
}
