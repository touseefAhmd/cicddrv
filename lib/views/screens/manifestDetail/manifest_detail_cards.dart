import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final dynamic item;

  const ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 📦 Left Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.inventory_2_outlined,
                color: Colors.blue),
          ),

          const SizedBox(width: 10),

          /// 📄 Item Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Description
                Text(
                  item['description'] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                /// SKU
                Text(
                  "SKU: ${item['sku']}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                /// Qty + Weight Row
                Row(
                  children: [
                    _infoChip("Qty", "${item['qty']}"),
                    const SizedBox(width: 8),
                    _infoChip("Wt", "${item['wt']} lbs"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Small reusable chip widget
  Widget _infoChip(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "$title: $value",
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}