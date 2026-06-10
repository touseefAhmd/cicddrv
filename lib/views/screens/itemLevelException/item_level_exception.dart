// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'confirm_item_level_exception.dart';

// ─── Dummy Data Model ────────────────────────────────────────────────────────

class DummyItem {
  final int id;
  final String description;
  final String barCode;
  final String sku;
  final String weight;
  final String volume;

  DummyItem({
    required this.id,
    required this.description,
    required this.barCode,
    required this.sku,
    required this.weight,
    required this.volume,
  });
}

// ─── Dummy State Controller ───────────────────────────────────────────────────

class _ItemExceptionState {
  final RxBool checked = false.obs;
  final RxString reason = ''.obs;
  final RxString note = ''.obs;
  late final TextEditingController textController;

  _ItemExceptionState() {
    textController = TextEditingController();
  }

  void dispose() => textController.dispose();
}

// ─── View ─────────────────────────────────────────────────────────────────────

class ItemLevelExceptionView extends StatefulWidget {
  const ItemLevelExceptionView({super.key});

  @override
  State<ItemLevelExceptionView> createState() => _ItemLevelExceptionViewState();
}

class _ItemLevelExceptionViewState extends State<ItemLevelExceptionView> {
  static const _navyDark = Color(0xFF0F2236);
  static const _navyCard = Color(0xFF1E3A56);
  static const _navyAppBar = Color(0xFF1A3A5C);

  final List<DummyItem> _items = [
    DummyItem(
      id: 1,
      description: 'Samsung 65" QLED TV',
      barCode: '8806094953',
      sku: 'SAM-TV-65Q',
      weight: '48.5',
      volume: '21.4',
    ),
    DummyItem(
      id: 2,
      description: 'LG Refrigerator 26 Cu Ft',
      barCode: '7503016342',
      sku: 'LG-FRIDGE-26',
      weight: '312.0',
      volume: '43.8',
    ),
    DummyItem(
      id: 3,
      description: 'Whirlpool Washer Front Load',
      barCode: '5012345678',
      sku: '',
      weight: '198.0',
      volume: '27.6',
    ),
    DummyItem(
      id: 4,
      description: 'Dell Monitor 27" 4K',
      barCode: '6932491872',
      sku: 'DELL-MON-27',
      weight: '14.2',
      volume: '8.1',
    ),
  ];

  final List<String> _exceptionReasons = [
    'Damaged packaging',
    'Missing parts',
    'Wrong item',
    'Item broken',
    'Quantity mismatch',
    'Other',
  ];

  late final List<_ItemExceptionState> _states;

  @override
  void initState() {
    super.initState();
    _states = List.generate(_items.length, (_) => _ItemExceptionState());
  }

  @override
  void dispose() {
    for (final s in _states) {
      s.dispose();
    }
    super.dispose();
  }

  // ─── Validation & Confirm ──────────────────────────────────────────────────

  void _onConfirm() {
    final checkedIndices = <int>[];
    for (int i = 0; i < _states.length; i++) {
      if (_states[i].checked.isTrue) checkedIndices.add(i);
    }

    if (checkedIndices.isEmpty) {
      Get.snackbar(
        'No Items Selected'.tr,
        'Please check at least one item to raise an exception.'.tr,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final invalid = checkedIndices.any(
          (i) =>
      _states[i].reason.value.isEmpty ||
          _states[i].note.value.trim().isEmpty,
    );

    if (invalid) {
      Get.snackbar(
        'Required Field Error'.tr,
        'Select a reason and add a note for every checked item.'.tr,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: replace with real navigation / data submission
    final summary = checkedIndices
        .map((i) =>
    '${_items[i].description}: ${_states[i].reason.value} — "${_states[i].note.value}"')
        .join('\n');

    final exceptionData = checkedIndices.map((i) {
      return <String, dynamic>{
        'barcode': _items[i].barCode,
        'sku': _items[i].sku,
        'exception_code': _states[i].reason.value,
        'exception_note': _states[i].note.value.trim(),
      };
    }).toList();

    Get.to(() => ConfirmItemExceptionView(
      data: exceptionData,
      stopNote: '',        // replace with your real stopNoteText when wiring
    ));
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: _navyDark,

        // ── AppBar ───────────────────────────────────────────────────────────
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
                  'Item Level Exception'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Select items with issues'.tr,
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
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),

        // ── Body ─────────────────────────────────────────────────────────────
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          itemCount: _items.length,
          itemBuilder: (context, index) =>
              _buildItemCard(_items[index], _states[index]),
        ),

        // ── Footer ───────────────────────────────────────────────────────────
        bottomNavigationBar: SizedBox(
          height: screenHeight * 0.11,
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
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: Text(
                      'Confirm'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: _onConfirm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Item Card ─────────────────────────────────────────────────────────────

  Widget _buildItemCard(DummyItem item, _ItemExceptionState state) {
    return Obx(
          () => Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: _navyCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    state.checked.toggle();
                    if (!state.checked.value) {
                      state.reason.value = '';
                      state.note.value = '';
                      state.textController.clear();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(top: 2, right: 10),
                    decoration: BoxDecoration(
                      color: state.checked.isTrue
                          ? const Color(0xFF4CAF50)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: state.checked.isTrue
                            ? const Color(0xFF4CAF50)
                            : Colors.white38,
                        width: 2,
                      ),
                    ),
                    child: state.checked.isTrue
                        ? const Icon(Icons.check,
                        color: Colors.white, size: 14)
                        : null,
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (state.checked.isTrue)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Exception',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF81C784),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(color: Colors.white24, height: 24),

            // ── Info Grid ───────────────────────────────────────────────────
            Row(
              children: [
                Expanded(child: _infoCell('Barcode', item.barCode)),
                if (item.sku.isNotEmpty)
                  Expanded(child: _infoCell('SKU', item.sku))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _infoCell('Weight', '${item.weight} lbs')),
                Expanded(child: _infoCell('Volume', '${item.volume} CuFt')),
              ],
            ),

            // ── Exception Panel ─────────────────────────────────────────────
            if (state.checked.isTrue) ...[
              const SizedBox(height: 14),
              _buildExceptionPanel(item, state),
            ],
          ],
        ),
      ),
    );
  }

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

  // ─── Exception Panel ───────────────────────────────────────────────────────

  Widget _buildExceptionPanel(DummyItem item, _ItemExceptionState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reason dropdown
          _panelLabel('Exception reason'),
          const SizedBox(height: 6),
          Obx(
                () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A5C),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24),
              ),
              child: DropdownButton<String>(
                value:
                state.reason.value.isEmpty ? null : state.reason.value,
                hint: Text(
                  '-- Select reason --'.tr,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                dropdownColor: const Color(0xFF1A3A5C),
                items: _exceptionReasons
                    .map(
                      (r) => DropdownMenuItem(
                    value: r,
                    child: Text(
                      r,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13),
                    ),
                  ),
                )
                    .toList(),
                onChanged: (val) {
                  if (val != null) state.reason.value = val;
                },
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Note field
          _panelLabel('Exception note'),
          const SizedBox(height: 6),
          TextField(
            controller: state.textController,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Describe the issue...'.tr,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.orange.withOpacity(0.18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                const BorderSide(color: Colors.orangeAccent, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Colors.orangeAccent.withOpacity(0.4), width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                const BorderSide(color: Colors.orangeAccent, width: 1),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            onChanged: (val) => state.note.value = val,
          ),
        ],
      ),
    );
  }

  Widget _panelLabel(String text) => Text(
    text.toUpperCase().tr,
    style: const TextStyle(
      fontSize: 10,
      color: Colors.white38,
      letterSpacing: 0.6,
    ),
  );
}