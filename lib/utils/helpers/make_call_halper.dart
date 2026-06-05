import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../snackbar.dart';


class MakeCallHelper {
  static Future<void> makeCall() async {

    final Uri url = Uri.parse("tel:9084287300");
    if (kIsWeb) {
      // On web, just try to launch; may work on mobile browsers.
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        HSnackBar.customSnackBar(type: SnackBarType.error, message: "Dial pad is not supported in web mode");
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Native app environment — works perfectly
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {

        HSnackBar.customSnackBar(type: SnackBarType.error, message: "Unable to open dial pad");
      }
    } else {
      Get.snackbar("Error", "Not supported on this platform");
      HSnackBar.customSnackBar(type: SnackBarType.error, message: "Not supported on this platform");
    }
  }
}