// ignore_for_file: sized_box_for_whitespace

import 'package:driver_app/views/screens/itemLevelException/item_level_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ─────────────────────────────────────────────
///  Static colour constants (replace with your
///  AppColors class when integrating)
/// ─────────────────────────────────────────────
class _Colors {
  static const appBar = Color(0xFF2C3E50);
  static const cardBg = Color(0xFF3D4F61);
  static const cardText = Colors.white;
  static const phoneBtn = Color(0xFFE74C3C);
  static const imageBadgeOk = Color(0xFF27AE60);
  static const imageBadgeMissing = Color(0xFFE74C3C);
  static const orderException = Color(0xFFE74C3C);
  static const complete = Color(0xFF27AE60);
  static const timerBadge = Color(0xFF34495E);
}

/// ─────────────────────────────────────────────
///  Entry point – pure static / UI-only screen
/// ─────────────────────────────────────────────
class StopArrivalView extends StatefulWidget {
  const StopArrivalView({super.key});

  @override
  State<StopArrivalView> createState() => _StopArrivalViewState();
}

class _StopArrivalViewState extends State<StopArrivalView> {
  final TextEditingController _noteController = TextEditingController();

  // ── Dummy static data (swap with controller later) ──────────────────────
  static const _loadId = '601842';
  static const _timerLabel = '01:12:26';

  static const _stopType = 'Delivery';
  static const _stopId = '5518628';
  static const _window = 'Win: 03:00 PM – 06:00 PM MST';
  static const _address = '732 Faraway Road, SNOWMASS VILLAGE CO 81615';
  static const _customerName = 'GHISLAINE BOREEL';
  static const _phone = '2022559123';
  static const _serviceCode = 'ROC';
  static const _serviceType = 'Room of Choice';
  static const _qty = 1;
  static const _weight = '44 lbs';
  static const _volume = '11 CuFt';
  static const _srvTime = '15 Min';
  static const _instructions = '&#x20;';
  static const _itemCount = 1;
  static const _imagesAttached = 0;
  static const _imagesRequired = 1;
  static const _isPickup = false; // false = Delivery
  // ────────────────────────────────────────────────────────────────────────

  bool _itemsExpanded = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final imagesOk = _imagesAttached >= _imagesRequired;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildOrderDetailCard(),
            const SizedBox(height: 10),
            _buildImagesCard(imagesOk),
            const SizedBox(height: 10),
            _buildNotesCard(),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(s),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        elevation: 4,
        backgroundColor: _Colors.appBar,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            const Text(
              'Load',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                _loadId,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ArrivalTimer(label: _timerLabel),
          ),
        ],
      ),
    );
  }

  // ── Order Detail Card ────────────────────────────────────────────────────
  Widget _buildOrderDetailCard() {
    return Card(
      color: _Colors.cardBg,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  _stopType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _stopId,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Time window
            Center(
              child: Text(
                _window,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
            const Divider(color: Colors.white24, height: 20),

            // Address
            _cardLabel('Full Address:'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    _address,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                _iconBtn(Icons.copy, () {}),
                _iconBtn(Icons.navigation, () {}),
              ],
            ),
            const Divider(color: Colors.white24, height: 20),

            // Customer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Customer Name:', style: TextStyle(color: Colors.white70, fontSize: 13)),
                Text(
                  _customerName,
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Phone button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _Colors.phoneBtn,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                icon: const Icon(Icons.phone, color: Colors.white, size: 16),
                label: const Text(_phone, style: TextStyle(color: Colors.white)),
              ),
            ),
            const Divider(color: Colors.white24, height: 20),

            // Service info
            _infoRow('Service Code:', _serviceCode),
            const SizedBox(height: 6),
            _infoRow('Service Type:', _serviceType),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Qty: $_qty;  Wt: $_weight;  Vol: $_volume;  Srv Time: $_srvTime',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Assembly Instructions banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.receipt_long, size: 18, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Assembly Instructions', style: TextStyle(color: Colors.black87, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Instructions text
            _cardLabel('Instructions:'),
            const SizedBox(height: 4),
            const Text(_instructions, style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 12),

            // Items expand row
            GestureDetector(
              onTap: () => setState(() => _itemsExpanded = !_itemsExpanded),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_itemCount Item(s)',
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      _itemsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            if (_itemsExpanded) ...[
              const SizedBox(height: 8),
              // Placeholder item row
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Item details will appear here', style: TextStyle(color: Colors.white54, fontSize: 13)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Images Card ──────────────────────────────────────────────────────────
  Widget _buildImagesCard(bool imagesOk) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: imagesOk ? _Colors.imageBadgeOk : _Colors.imageBadgeMissing,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Images',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                '$_imagesAttached / $_imagesRequired attached',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }

  // ── Notes Card ───────────────────────────────────────────────────────────
  Widget _buildNotesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _noteController,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            hintText: 'Please write notes here',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // ── Bottom Bar ───────────────────────────────────────────────────────────
  Widget _buildBottomBar(Size s) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Row(
          children: [
            // Order Exception
            Flexible(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _Colors.orderException,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, color: Colors.white),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Order Exception',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Complete Pickup / Delivery
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(ItemLevelExceptionView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _Colors.complete,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.white),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        _isPickup ? 'Complete Pickup' : 'Complete Delivery',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────
  Widget _cardLabel(String text) => Text(
    text,
    style: const TextStyle(color: Colors.white70, fontSize: 13),
  );

  Widget _infoRow(String label, String value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
    ],
  );

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(icon, color: Colors.white70, size: 20),
    ),
  );
}

/// ─────────────────────────────────────────────
///  Arrival Timer Badge  (replaces ArrivalCounter)
/// ─────────────────────────────────────────────
class _ArrivalTimer extends StatelessWidget {
  const _ArrivalTimer({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}