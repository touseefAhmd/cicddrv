// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DummySignatureDialog {
  static const _navyAppBar = Color(0xFF1A3A5C);

  void showDefaultDialog({
    required BuildContext context,
    required List<Map<String, dynamic>> exceptionData,
    required String stopNote,
  }) {
    final signaturePadKey = GlobalKey<SfSignaturePadState>();
    final nameController = TextEditingController();

    Future<bool> hasSignature() async {
      final img =
      await signaturePadKey.currentState?.toImage(pixelRatio: 1.0);
      if (img == null) return false;
      final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
      if (bytes == null) return false;
      return bytes.lengthInBytes > 1000;
    }

    Get.defaultDialog(
      radius: 12,
      barrierDismissible: false,
      backgroundColor: const Color(0xFF0F2236),
      titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
      title: 'Customer Signature',
      content: Flexible(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                // ── Signature Pad ──────────────────────────────────────────
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.38,
                      width: MediaQuery.of(context).size.width * 0.88,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SfSignaturePad(
                          key: signaturePadKey,
                          backgroundColor: Colors.grey[200]!,
                          strokeColor: Colors.black87,
                          minimumStrokeWidth: 1.5,
                          maximumStrokeWidth: 4.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => signaturePadKey.currentState?.clear(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.refresh,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Customer Name ──────────────────────────────────────────
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Customer Name'.tr,
                    labelStyle:
                    const TextStyle(color: Colors.white54, fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFF1E3A56),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.white30, width: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.88,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC62828),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(44),
                  ),
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  label: Text('Close'.tr,
                      style: const TextStyle(color: Colors.white)),
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(44),
                  ),
                  icon: const Icon(Icons.check, color: Colors.white, size: 18),
                  label: Text('Depart'.tr,
                      style: const TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final signed = await hasSignature();
                    final name = nameController.text.trim();

                    if (!signed || name.isEmpty) {
                      Get.snackbar(
                        'Error'.tr,
                        'Please sign the invoice and enter customer name.'.tr,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    final img = await signaturePadKey.currentState
                        ?.toImage(pixelRatio: 2.0);
                    if (img == null) {
                      Get.snackbar('Error'.tr, 'Failed to capture signature.'.tr,
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }

                    final byteData =
                    await img.toByteData(format: ui.ImageByteFormat.png);
                    if (byteData == null) {
                      Get.snackbar('Error'.tr, 'Failed to encode signature.'.tr,
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }

                    final bs64Sign =
                    base64Encode(byteData.buffer.asUint8List());

                    await _handleDepart(
                      context: context,
                      bs64Sign: bs64Sign,
                      customerName: name,
                      exceptionData: exceptionData,
                      stopNote: stopNote,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Depart Handler ─────────────────────────────────────────────────────────

  Future<void> _handleDepart({
    required BuildContext context,
    required String bs64Sign,
    required String customerName,
    required List<Map<String, dynamic>> exceptionData,
    required String stopNote,
  }) async {
    try {
      // Close signature dialog
      Get.back();

      // Show processing indicator
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        radius: 8,
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            LinearProgressIndicator(color: Color(0xFF1A3A5C)),
            SizedBox(height: 10),
            Text('Processing...',
                style: TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      );

      // TODO: replace the block below with your real upload calls:
      //
      // await CreateJSON.createItemLevelExceptionJSON(...);
      // await CreateImagesJSON.createImgJSON();
      // await WorkOnCreatingSigJson(bs64Sign, customerName);
      // await RemoveArrivalCounter.removeArrivalCounter();
      // GetStorage().write("isArrived", false);
      // ... then Get.offAll(() => const ManifestDetailTabs());
      //
      // For now we simulate a short async operation:
      await Future.delayed(const Duration(seconds: 2));

      if (Get.isDialogOpen ?? false) Get.back();

      Get.snackbar(
        'Departed'.tr,
        'Stop completed for $customerName. '
            '${exceptionData.length} exception(s) recorded.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      // TODO: uncomment when wiring real flow
      // Get.offAll(() => const ManifestDetailTabs());
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar(
        'Error'.tr,
        'Failed to save data. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('DummySignatureDialog error: $e');
    }
  }
}