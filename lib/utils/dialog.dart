import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogBox {
  /// CONFIRMATION DIALOG
  static void confirmationDialog({
    required String message,
    required Function() onYes,
    String title = "Confirmation",
    String yesText = "Yes",
    String noText = "No",
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // close dialog
            },
            child: Text(noText),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // close dialog first
              await onYes(); // then run action
            },
            child: Text(yesText),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// INFO / ERROR DIALOG
  static void infoDialog({
    required String title,
    required String message,
    String buttonText = "OK",
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  /// LOADING DIALOG (optional but useful)
  static void loadingDialog({String message = "Loading..."}) {
    Get.dialog(
      barrierDismissible: false,
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}