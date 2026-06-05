import 'package:flutter/material.dart';

class DrawerItemModel {
  final String title;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;

  DrawerItemModel({
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
  }) : assert(route != null || onTap != null,
  "Either route or onTap must be provided");
}