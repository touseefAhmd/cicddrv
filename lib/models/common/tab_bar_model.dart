import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class DynamicTabModel {
  /// SliverAppBar Config
  final bool pinned;
  final bool floating;
  final double expandedHeight;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;

  /// Optional custom widget in flexibleSpace
  final Widget? tabHeaderWidget;

  /// TabBar Config
  final bool isScrollable;
  final Color indicatorColor;
  final Color unselectedLabelColor;
  final Color labelColor;

  /// Tabs List
  final List<TabItemModel> tabItems;

  const DynamicTabModel({
    this.pinned = true,
    this.floating = true,
    this.backgroundColor = TColors.white,
    this.expandedHeight = 440,
    this.automaticallyImplyLeading = false,
    this.tabHeaderWidget,
    this.isScrollable = true,
    this.indicatorColor = TColors.darkAppBar,
    this.unselectedLabelColor = TColors.greyDark,
    this.labelColor = TColors.appBarDarkBackground,
    required this.tabItems,
  });

  /// Safe empty state
  static DynamicTabModel empty() => const DynamicTabModel(tabItems: []);

  /// Convenience: total tabs count
  int get length => tabItems.length;

  /// Safe access to a tab by index
  TabItemModel? tabAt(int index) {
    if (index < 0 || index >= tabItems.length) return null;
    return tabItems[index];
  }

  /// Call refresh for active tab
  void refreshTab(int index) {
    tabAt(index)?.onRefresh?.call();
  }
}

class TabItemModel {
  final String title;
  final Widget content;
  final bool keepAlive;

  /// Called when Layout refresh button is pressed
  final VoidCallback? onRefresh;

  const TabItemModel({
    required this.title,
    required this.content,
    this.keepAlive = true,
    this.onRefresh,
  });
}
