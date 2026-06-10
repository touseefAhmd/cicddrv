// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../signatureDialog/capture_signature.dart';

// ─── Dummy Data Model (matches what ItemLevelExceptionView passes) ────────────

class ConfirmItemExceptionView extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String stopNote;

  const ConfirmItemExceptionView({
    super.key,
    required this.data,
    required this.stopNote,
  });

  // ─── Colors (mirrors ItemLevelExceptionView) ────────────────────────────────
  static const _navyDark = Color(0xFF0F2236);
  static const _navyCard = Color(0xFF1E3A56);
  static const _navyAppBar = Color(0xFF1A3A5C);

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: _navyDark,

        // ── AppBar ─────────────────────────────────────────────────────────
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            backgroundColor: _navyAppBar,
            iconTheme: const IconThemeData(color: Colors.white),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirm'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Review all item exceptions before signature'.tr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),

        // ── Body ───────────────────────────────────────────────────────────
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Order Detail Card (placeholder) ──────────────────────────
              _buildOrderDetailPlaceholder(),

              const SizedBox(height: 12),

              // ── Section Header ────────────────────────────────────────────
              _sectionLabel(
                data.isEmpty
                    ? 'No item exceptions registered'.tr
                    : 'Item level exceptions'.tr,
              ),

              const SizedBox(height: 8),

              // ── Exception List or Empty State ─────────────────────────────
              data.isEmpty
                  ? _buildEmptyState()
                  : Column(
                children: List.generate(
                  data.length,
                      (i) => _buildExceptionCard(data[i]),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),

        // ── Footer ─────────────────────────────────────────────────────────
        bottomNavigationBar: SizedBox(
          height: s.height * 0.11,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Row(
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC62828),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: Text(
                      'Back'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    icon: const Icon(Icons.draw_outlined, color: Colors.white),
                    label: Text(
                      'Take Signature'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // TODO: wire back to your SignatureDialog call
                      // SignatureDialog().showDefaultDialog(
                      //   jsonUnencoded: createItemsExceptionJsonOnlyException(),
                      //   stopNote: stopNote,
                      //   imgLength: imagesLength,
                      //   context: context,
                      // );

                      DummySignatureDialog().showDefaultDialog(
                        context: context,
                        exceptionData: data,
                        stopNote: stopNote,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Order Detail Placeholder ──────────────────────────────────────────────
  // Replace with your real ReusableOrderDetailCard() when wiring back

  Widget _buildOrderDetailPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined,
                  color: Colors.white54, size: 18),
              const SizedBox(width: 8),
              _cellLabel('Order details'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _infoCell('Order ID', 'ORD-00472')),
              Expanded(child: _infoCell('Stop', '#3 of 7')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _infoCell('Customer', 'John Merritt')),
              Expanded(child: _infoCell('Address', '482 Elm St')),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Empty State ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle_outline,
              color: Colors.orangeAccent.withOpacity(0.7), size: 36),
          const SizedBox(height: 10),
          Text(
            'No item exceptions registered'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Exception Card ────────────────────────────────────────────────────────

  Widget _buildExceptionCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top: barcode + exception badge ──────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.qr_code_2, color: Colors.white38, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['barcode']?.toString() ?? '—',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item['exception_code']?.toString() ?? '—',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const Divider(color: Colors.white24, height: 20),

          // ── Info Grid ────────────────────────────────────────────────────
          if (item['sku']?.toString().isNotEmpty == true) ...[
            _infoCell('SKU', item['sku'].toString()),
            const SizedBox(height: 8),
          ],

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _infoCell(
                  'Exception note',
                  item['exception_note']?.toString() ?? '—',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Shared Helpers ────────────────────────────────────────────────────────

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 2, bottom: 2),
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        color: Colors.white38,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _cellLabel(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 10,
      color: Colors.white38,
      letterSpacing: 0.6,
    ),
  );

  Widget _infoCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white38,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}