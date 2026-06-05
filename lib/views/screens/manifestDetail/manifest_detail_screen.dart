import 'dart:convert';
import 'package:driver_app/views/screens/stopArrival/stop_arrival_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/common/drawer_item_model.dart';
import '../../../models/common/tab_bar_model.dart';
import '../../../utils/helpers/make_call_halper.dart';
import '../../../utils/theme/theme.dart';
import '../../../widgets/layout.dart';
import '../../../widgets/tabbar/tabbar.dart';


class ManifestDetailScreen extends StatelessWidget {
  const ManifestDetailScreen({super.key});

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

    final dummyStops = [
      {
        "sequence": 1,
        "totalStops": 3,
        "address": "180 Deer Run, Carbondale CO 81623",
        "etaDate": "12 Apr 2026",
        "etaTime": "10:30 AM",
        "orders": [
          {
            "orderNo": "ORD-1001",
            "customer": "Kelsey Ellis",
            "service": "Delivery",
            "items": [
              {"desc": "Barcode", "012999229": 2},
              {"desc": "Weight", "17": 5},
            ],
          },
          {
            "orderNo": "ORD-1002",
            "customer": "Alice",
            "service": "Pickup",
            "items": [
              {"desc": "Item C", "qty": 3},
            ],
          }
        ],
      },
      {
        "sequence": 2,
        "totalStops": 3,
        "address": "Los Angeles Port",
        "etaDate": "13 Apr 2026",
        "etaTime": "02:00 PM",
        "orders": [
          {
            "orderNo": "ORD-2001",
            "customer": "Michael",
            "service": "Delivery",
            "items": [
              {"desc": "Item D", "qty": 5},
            ],
          }
        ],
      },
    ];

    // Define tabs
    final tabsData = DynamicTabModel(
      backgroundColor: AppTheme.cardBackgroundColor(context),
      indicatorColor: AppTheme.labelColor(context),
      unselectedLabelColor: AppTheme.labelColor(context),
      labelColor: AppTheme.tabsSelectedColor(context),
      expandedHeight: 200,
      tabItems: [
        TabItemModel(
          title: 'List',
          content: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: dummyStops.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final stop = dummyStops[i];

              return ExpansionTile(
                backgroundColor: AppTheme.cardBackgroundColor(context),
                collapsedBackgroundColor: AppTheme.cardBackgroundColor(context),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// STOP HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stop ${stop["sequence"]}/${stop["totalStops"]}",
                          style:  TextStyle(
                              color: AppTheme.valueColor(context), fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${(stop["orders"] as List).length} Orders",
                          style:  TextStyle(color: AppTheme.valueColor(context)),
                        ),
                      ],
                    ),
                     Divider(color: AppTheme.valueColor(context)),
                    Text(
                      stop["address"].toString(),
                      style:  TextStyle(
                          color: AppTheme.valueColor(context), fontWeight: FontWeight.bold),
                    ),
                    Divider(color: AppTheme.labelColor(context)),
                    Text(
                      stop["etaDate"].toString(),
                      style:  TextStyle(color: AppTheme.valueColor(context)),
                    ),
                    Text(
                      stop["etaTime"].toString(),
                      style: TextStyle(color: AppTheme.valueColor(context)),
                    ),
                  ],
                ),
                children: (stop["orders"] as List).map((order) {
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      color: AppTheme.appBarBackground(context),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ORDER HEADER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order["orderNo"].toString(),
                                  style:  TextStyle(
                                      color: AppTheme.valueColor(context),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Single ARRIVE button for each stop
                                if (i == 0) // Example: only first stop has the ARRIVE button
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(StopArrivalView());
                                    },
                                    child: const Text("ARRIVE"),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                             Divider(color: AppTheme.valueColor(context)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Customer:",
                                    style: TextStyle(color: AppTheme.valueColor(context))),
                                Text(order["customer"].toString(),
                                    style: TextStyle(color: AppTheme.valueColor(context))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Service:",
                                    style: TextStyle(color: AppTheme.lightColor)),
                                Text(order["service"].toString(),
                                    style:  TextStyle(color: AppTheme.valueColor(context))),
                              ],
                            ),
                            const SizedBox(height: 10),

                            /// ITEMS LIST
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.valueColor(context), width: 1.25),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ExpansionTile(
                                iconColor: AppTheme.labelColor(context),
                                collapsedIconColor: AppTheme.labelColor(context),
                                title: Center(
                                  child: Text(
                                    "${(order["items"] as List).length} Item(s)",
                                    style:  TextStyle(color: AppTheme.valueColor(context)),
                                  ),
                                ),
                                children: (order["items"] as List).map((item) {
                                  return ListTile(
                                    title: Text(
                                      item["desc"].toString(),
                                      style:  TextStyle(color: AppTheme.valueColor(context)),
                                    ),
                                    trailing: Text(
                                      "Qty: ${item["qty"]}",
                                      style:  TextStyle(color: AppTheme.valueColor(context)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        TabItemModel(
          title: 'Maps',
          content: const Center(
            child: Text("Map view of stops will be shown here"),
          ),
        ),
        TabItemModel(
          title: 'Completed',
          content: const Center(
            child: Text("Completed stops go here"),
          ),
        ),
      ],
    );

    return Layout(
      title: "Manifest Detail",
      showBackArrow: true,
      //showDrawerIcon: true,
      drawerMenuItems: drawerItems,
      child: DynamicTabs(data: tabsData),
    );
  }
}

