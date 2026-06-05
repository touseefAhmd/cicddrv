import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../utils/theme/theme.dart';
import '../utils/theme/theme_provider.dart';


enum AppBarTitleAlignment { left, center, right }

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final AppBarTitleAlignment titleAlignment;
  final double? titleFontSize;
  final List<Widget>? leftWidgets;
  final List<Widget>? rightWidgets;

  const AppBarWidget({
    super.key,
    this.title,
    this.titleAlignment = AppBarTitleAlignment.center,
    this.titleFontSize,
    this.leftWidgets,
    this.rightWidgets,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final titleStyle = AppTheme.headerStyle(context);
    final appBarTitle = title ?? Get.currentRoute.split('/').last.capitalizeFirst ?? 'App';
    final List<Widget> finalRightWidgets = [...?rightWidgets];
    finalRightWidgets.add(
      IconButton(
        icon: Icon(themeProvider.isDark ? Icons.light_mode : Icons.dark_mode, color: AppTheme.appBarIconColor(context)),
        onPressed: () => themeProvider.toggleTheme(),
      ),
    );
    return AppBar(
      leading: (leftWidgets != null && leftWidgets!.isNotEmpty)
          ? Row(mainAxisSize: MainAxisSize.min, children: leftWidgets!)
          : null,
      title: _buildTitle(appBarTitle, titleStyle),
      centerTitle: titleAlignment == AppBarTitleAlignment.center,
      elevation: 2,
      backgroundColor: AppTheme.scaffoldBackground(context),
      actions: finalRightWidgets,
      iconTheme: IconThemeData(color: AppTheme.appBarIconColor(context)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildTitle(String text, TextStyle style) {
    Alignment alignment;
    switch (titleAlignment) {
      case AppBarTitleAlignment.left:
        alignment = Alignment.centerLeft;
        break;
      case AppBarTitleAlignment.right:
        alignment = Alignment.centerRight;
        break;
      default:
        alignment = Alignment.center;
    }

    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      ),
    );
  }
}
