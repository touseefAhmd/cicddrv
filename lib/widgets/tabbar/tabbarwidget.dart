import 'package:flutter/material.dart';

import '../../models/common/tab_bar_model.dart';
import '../../utils/theme/theme.dart';

class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<TabItemModel> items;
  final bool isScrollable;
  final Color indicatorColor;
  final Color unselectedLabelColor;
  final Color labelColor;
  final TabController? tabController;

  const TabBarWidget({
    super.key,
    required this.items,
    this.isScrollable = true,
    required this.indicatorColor,
    required this.unselectedLabelColor,
    required this.labelColor,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.scaffoldBackground(context),
      child: TabBar(
        controller: tabController,
        tabs: items.map((item) => Tab(text: item.title)).toList(),
        isScrollable: isScrollable,
        indicatorColor: indicatorColor,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
