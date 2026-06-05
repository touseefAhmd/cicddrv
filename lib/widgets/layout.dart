import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/common/drawer_item_model.dart';
import '../utils/theme/theme.dart';
import '../utils/theme/theme_provider.dart';
import 'appbar_widget.dart';

class Layout extends StatefulWidget {
  final Widget child;
  final String title;
  final AppBarTitleAlignment titleAlignment;
  final double? titleFontSize;

  //  Bit controls (null = false)
  final bool? showBackArrow;
  final bool? showDrawerIcon;
  final bool? showLogout;

  final VoidCallback? backArrowOnPressed;

  final bool refresh;
  final Function? refreshOnPressed;

  final List<DrawerItemModel>? drawerMenuItems;
  final List<Widget>? rightWidgets;

  const Layout({
    super.key,
    required this.child,
    this.title = '',
    this.titleAlignment = AppBarTitleAlignment.center,
    this.titleFontSize,
    this.showBackArrow,
    this.showDrawerIcon,
    this.showLogout,
    this.backArrowOnPressed,
    this.refresh = false,
    this.refreshOnPressed,
    this.drawerMenuItems,
    this.rightWidgets,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Key childKey = UniqueKey();

  void _refreshPage() {
    if (widget.refreshOnPressed != null) {
      widget.refreshOnPressed!();
    } else {
      setState(() {
        childKey = UniqueKey();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    //appPrint("${savedModule?.title ?? "module is null"} saved module");
    //Vendor Pickup
    //Yard Management
    //Warehouse Management

    final staticDrawerItems = <DrawerItemModel>[
      // DrawerItemModel(title: "Logs", icon: Icons.history, route: AppRoutes.logs),
      // DrawerItemModel(title: "Change Module", icon: Icons.change_circle_rounded, route: AppRoutes.home),
      // DrawerItemModel(title: "Profile", icon: Icons.person, route: AppRoutes.profile),
      // DrawerItemModel(title: "Settings", icon: Icons.settings, route: AppRoutes.settings),
    ];

    // Original drawer logic kept
    final drawerItems = widget.drawerMenuItems?.isNotEmpty == true
        ? [...widget.drawerMenuItems!, ...staticDrawerItems]
        : staticDrawerItems;

    // ---------------- LEFT APPBAR ICONS ----------------
    final List<Widget> leftWidgets = [];
  //  final auth = Provider.of<AuthProvider>(context, listen: false);

    final showBack = widget.showBackArrow ?? false;
    final showDrawer = widget.showDrawerIcon ?? false;
    final showLogout = widget.showLogout ?? false;

    if (showBack) {
      leftWidgets.add(
        IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.valueColor(context)),
          onPressed:
          widget.backArrowOnPressed ?? () => Navigator.of(context).maybePop(),
        ),
      );
    }

    if (showDrawer) {
      leftWidgets.add(
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: AppTheme.valueColor(context)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      );
    }

    if (showLogout) {
      // leftWidgets.add(
      //   IconButton(
      //     icon: Icon(Icons.logout, color: AppTheme.valueColor(context)),
      //   //  onPressed: () => auth.logout(),
      //   ),
      // );
    }

    // ---------------- RIGHT APPBAR ICONS ----------------
    final List<Widget> rightWidgets = [];

    if (widget.refresh) {
      rightWidgets.add(
        IconButton(
          icon: Icon(Icons.refresh, color: AppTheme.valueColor(context)),
          onPressed: _refreshPage,
        ),
      );
    }

    if (widget.rightWidgets != null && widget.rightWidgets!.isNotEmpty) {
      rightWidgets.addAll(widget.rightWidgets!);
    }

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground(context),
      appBar: AppBarWidget(
        title: widget.title.isEmpty?"":widget.title,
        titleAlignment: widget.titleAlignment,
        titleFontSize: widget.titleFontSize,
        leftWidgets: leftWidgets,
        rightWidgets: rightWidgets,
      ),
      drawer: drawerItems.isNotEmpty
          ? Drawer()
          : null,
      body: SafeArea(
        child: KeyedSubtree(
          key: childKey,
          child: widget.child,
        ),
      ),
    );
  }
}
