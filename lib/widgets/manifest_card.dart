import 'package:flutter/material.dart';
import '../utils/theme/theme.dart';

class ManifestCard extends StatelessWidget {
  final String location;
  final String manifestId;
  final String driverName;
  final String date;
  final String truckId;
  final String truckName;
  final String notes;

  final int stopsTotal;
  final int stopsCompleted;
  final int stopsPending;

  final int ordersTotal;
  final int ordersCompleted;
  final int ordersPending;

  final String actionText;
  final IconData actionIcon;
  final VoidCallback onActionTap;

  const ManifestCard({
    super.key,
    required this.location,
    required this.manifestId,
    required this.driverName,
    required this.date,
    required this.truckId,
    required this.truckName,
    required this.notes,
    required this.stopsTotal,
    required this.stopsCompleted,
    required this.stopsPending,
    required this.ordersTotal,
    required this.ordersCompleted,
    required this.ordersPending,
    required this.actionText,
    required this.actionIcon,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cardBackgroundColor(context),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= TOP =================
            Text(
              location,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),

            Text(
              manifestId,
              style: AppTheme.headerStyle(context),
            ),

            const Divider(height: 20),

            // ================= DETAILS =================
            _detail("Driver Name", driverName, context),
            _detail("Date", date, context),
            _detail("Truck ID", truckId, context),
            _detail("Truck Name", truckName, context),
            _detail("Notes", notes, context),

            const SizedBox(height: 14),

            // ================= STATS =================
            Row(
              children: [
                Expanded(
                  child: _statsBox(
                    title: "Stops",
                    total: stopsTotal,
                    completed: stopsCompleted,
                    pending: stopsPending,
                    context: context,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statsBox(
                    title: "Orders",
                    total: ordersTotal,
                    completed: ordersCompleted,
                    pending: ordersPending,
                    context: context,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ================= ACTION =================
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onActionTap,
                icon: Icon(
                  actionIcon,
                  color: AppTheme.valueColor(context),
                ),
                label: Text(
                  actionText,
                  style: AppTheme.valueStyle(context),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.appBarBackground(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= DETAIL ROW =================
  Widget _detail(String title, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.labelColor(context),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppTheme.valueColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= STATS BOX =================
  Widget _statsBox({
    required String title,
    required int total,
    required int completed,
    required int pending,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: AppTheme.appBarBackground(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.headerColor(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Total: $total",
            style: TextStyle(color: AppTheme.valueColor(context)),
          ),
          Text(
            "Completed: $completed",
            style: TextStyle(color: AppTheme.valueColor(context)),
          ),
          Text(
            "Pending: $pending",
            style: TextStyle(color: AppTheme.valueColor(context)),
          ),
        ],
      ),
    );
  }
}