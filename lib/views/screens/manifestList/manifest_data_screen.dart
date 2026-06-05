import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/common/drawer_item_model.dart';
import '../../../models/common/tab_bar_model.dart';
import '../../../utils/dialog.dart';
import '../../../utils/helpers/make_call_halper.dart';
import '../../../utils/theme/theme.dart';
import '../../../widgets/layout.dart';
import '../../../widgets/tabbar/tabbar.dart';
import '../../userComplience/user_complience_screen.dart';
import '../manifestDetail/manifest_detail_screen.dart';
import 'dynamic_manifest_list.dart';

class ManifestDataScreen extends StatefulWidget {
  const ManifestDataScreen({super.key});

  @override
  State<ManifestDataScreen> createState() => _ManifestDataScreenState();
}

class _ManifestDataScreenState extends State<ManifestDataScreen> {
  @override
  Widget build(BuildContext context) {

    final drawerItems = [
      DrawerItemModel(
        title: "Driver's hotline",
        icon: Icons.call,
        onTap: () {
          MakeCallHelper.makeCall();
        },
      ),
    ];

    final tabsData = DynamicTabModel(
      backgroundColor: AppTheme.cardBackgroundColor(context),
      indicatorColor: AppTheme.labelColor(context),
      unselectedLabelColor: AppTheme.labelColor(context),
      labelColor: AppTheme.tabsSelectedColor(context),
      expandedHeight: 200,
      tabItems: [

        // ================= ASSIGNED =================
        TabItemModel(
          title: 'Assigned',
          content: DynamicManifestList(
            status: "open",
            actionText: "Load Level Image",
            actionIcon: Icons.image_outlined,
            onActionTap: (index) {
              Get.to(() => DriverComplianceUIScreen(manID: 12312));
            },
          ),
        ),

        // ================= READY TO GO =================
        TabItemModel(
          title: 'Ready To Go',
          content: DynamicManifestList(
            status: "COMPLETED",
            actionText: "Start",
            actionIcon: Icons.play_arrow,
            onActionTap: (index) {
              Get.to(() => ManifestDetailScreen());
              // CustomDialogBox.confirmationDialog(
              //   message: "Are you sure you want to start this manifest?",
              //   onYes: () {
              //     Get.back(); // close dialog (safe)
              //
              //     Future.delayed(const Duration(milliseconds: 200), () {
              //       Get.to(() => ManifestDetailScreen());
              //     });
              //   },
              // );
            },
          ),
        ),

        // ================= IN PROGRESS =================
        TabItemModel(
          title: 'In Progress',
          content: const DynamicManifestList(
            status: "open",
            actionText: "Complete",
            actionIcon: Icons.check_circle_outline,
          ),
        ),
      ],
    );

    return Layout(
      title: "Loads",
      showDrawerIcon: true,
      drawerMenuItems: drawerItems,
      child: DynamicTabs(data: tabsData),
    );
  }
}