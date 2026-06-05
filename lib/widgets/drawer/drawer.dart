// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:provider/provider.dart';
// import '../../../app/middlewares/environment_service.dart';
// import '../../../app/routes/app_routes.dart';
// import '../../../app/theme/app_theme.dart';
// import '../../../models/common/drawer_model.dart';
// import '../../../providers/authProvider/auth_provider.dart';
// import '../../../services/storageService/preference_service.dart';
// import '../../../views/modules/setting/yms_navigator.dart';
// import '../../utils/theme/theme.dart';
//
// class AppDrawer extends StatefulWidget {
//   final String userName;
//   final String userLabel;
//   final String userImageUrl;
//   final List<DrawerItemModel> items;
//
//   const AppDrawer({
//     super.key,
//     required this.userName,
//     required this.userLabel,
//     required this.userImageUrl,
//     required this.items,
//   });
//
//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }
//
// class _AppDrawerState extends State<AppDrawer> {
//   String version = "";
//   String buildNumber = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPackageInfo();
//   }
//
//   Future<void> _loadPackageInfo() async {
//     final info = await PackageInfo.fromPlatform();
//
//     setState(() {
//       version = info.version;
//       buildNumber = info.buildNumber;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context, listen: false);
//
//     Color getEnvTextColor() {
//       switch (EnvService.instance.environment.name.toLowerCase()) {
//         case 'test':
//           return Colors.red.shade400; // Test environment
//         case 'staging':
//           return Colors.orange; // Staging
//         case 'prod':
//         default:
//           return Colors.transparent;
//       }
//     }
//
//     return Drawer(
//       backgroundColor: AppTheme.drawerBackground(context),
//       child: Column(
//         children: [
//           //#region ====================== Drawer User Info ======================
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             color: AppTheme.drawerBackground(context),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: AppTheme.drawerBackground(context).withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     border: Border.all(color: AppTheme.drawerUserLabelColor(context)),
//                   ),
//                   child: Icon(Icons.person_outline, size: 32, color: AppTheme.drawerUserNameColor(context)),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         widget.userName.toUpperCase(),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: AppTheme.headerStyle(context),
//                       ),
//
//                       SizedBox(height: 4),
//
//                       Text(
//                           widget.userLabel,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTheme.valueStyle(context)
//                       ),
//
//                       if (EnvService.instance.environment.name.toLowerCase() != 'prod') ...[
//                         const SizedBox(height: 6),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: getEnvTextColor(),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                           child: Text(
//                             'Environment: ${EnvService.instance.environment.name.toUpperCase()}',
//                             style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           //#endregion ====================== Drawer User Info ======================
//
//           //#region ====================== Drawer Menu Items ======================
//           Expanded(
//             child: ListView.separated(
//               padding: EdgeInsets.zero,
//               itemCount: widget.items.length,
//               separatorBuilder: (_, __) => Divider(color: AppTheme.drawerDividerColor(context), height: 1),
//               itemBuilder: (context, index) {
//                 final item = widget.items[index];
//                 return ListTile(
//                   leading: Icon(item.icon, color: AppTheme.drawerItemIconColor(context)),
//                   tileColor: AppTheme.drawerItemColor(context),
//                   hoverColor: AppTheme.drawerItemHoverColor(context),
//                   splashColor: AppTheme.drawerItemHoverColor(context),
//                   title: Text(item.title, style: AppTheme.valueStyle(context)),
//                   onTap: () async {
//
//                     Navigator.pop(context); // close drawer first
//
//                     if (item.onTap != null) {
//                       item.onTap!();
//                       return;
//                     }
//
//
//                     if (item.route == AppRoutes.home) {
//                       await PreferenceService.clearSelectedModule();
//                       await PreferenceService.clearSelectedHub();
//                       await PreferenceService.clearSelectedAppointment();
//                       Get.offAllNamed(AppRoutes.home);
//                     } else if (item.route == AppRoutes.hubs) {
//                       await PreferenceService.clearSelectedHub();
//                       await PreferenceService.clearSelectedAppointment();
//                       YMSNavigator.navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.hubs, (route) => false);
//                     }
//
//                     else if (item.route == AppRoutes.moveRequestScreen) {
//                       YMSNavigator.navigatorKey.currentState
//                           ?.pushNamed(AppRoutes.moveRequestScreen);
//                     }
//
//                     else {
//                       Get.toNamed(item.route!);
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//           //#endregion ====================== Drawer Menu Items ======================
//
//           //#region ====================== Logout Section ======================
//           Divider(color: AppTheme.drawerDividerColor(context), height: 1),
//           ListTile(
//             tileColor: AppTheme.drawerItemColor(context),
//             leading: Icon(Icons.logout, color: AppTheme.drawerItemIconColor(context)),
//             title: Text('Logout', style: AppTheme.valueStyle(context)),
//             onTap: () => auth.logout(),
//           ),
//           //#endregion ====================== Logout Section ======================
//           //#region VERSION
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: Text(
//               "v $version ($buildNumber)",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: AppTheme.drawerUserLabelColor(context),
//               ),
//             ),
//           ),
//           //#endregion
//         ],
//       ),
//     );
//   }
// }
