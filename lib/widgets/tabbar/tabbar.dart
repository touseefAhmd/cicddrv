import 'package:driver_app/widgets/tabbar/tabbarwidget.dart';
import 'package:flutter/material.dart';

import '../../models/common/tab_bar_model.dart';
import 'keep_alive.dart';


class DynamicTabs extends StatelessWidget {
  final DynamicTabModel data;
  final TabController? tabController;
  const DynamicTabs({
    super.key,
    required this.data,
    this.tabController
  });

  @override
  Widget build(BuildContext context) {
    final tabItems = data.tabItems;
    final isScrollable = tabItems.length <= 3 ? false : true;

    return DefaultTabController(
      length: tabItems.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: data.pinned,
            floating: data.floating,
            backgroundColor: data.backgroundColor,
            automaticallyImplyLeading: data.automaticallyImplyLeading,
            expandedHeight: data.tabHeaderWidget != null ? data.expandedHeight : kToolbarHeight,
            flexibleSpace: data.tabHeaderWidget != null
                ? FlexibleSpaceBar(background: Padding(padding: EdgeInsets.only(top: 10), child: data.tabHeaderWidget))
                : null,

            bottom: TabBarWidget(

              tabController: tabController,
              items: tabItems,
              isScrollable: isScrollable,
              indicatorColor: data.indicatorColor,
              unselectedLabelColor: data.unselectedLabelColor,
              labelColor: data.labelColor,
            ),
          ),
        ],

        body: TabBarView(
          controller: tabController,
          children: tabItems.map((t) {
            // Wrap with KeepAliveWidget if keepAlive is true
            if (t.keepAlive) {
              return KeepAliveWidget(child: t.content);
            } else {
              return t.content;
            }
          }).toList(),
        ),
      ),
    );
  }
}
