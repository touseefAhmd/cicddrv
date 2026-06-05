import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/manifest_card.dart';

class DynamicManifestList extends StatefulWidget {
  final String actionText;
  final IconData actionIcon;
  final String status;
  final void Function(int index)? onActionTap;

  const DynamicManifestList({
    super.key,
    required this.actionText,
    required this.actionIcon,
    required this.status,
    this.onActionTap,
  });

  @override
  State<DynamicManifestList> createState() => _DynamicManifestListState();
}

class _DynamicManifestListState extends State<DynamicManifestList> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
    //  context.read<VendorPickupProviders>().loadManifestList(widget.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<VendorPickupProviders>(
    //   builder: (context, provider, child) {
    //
    //     // Loading State
    //     if (provider.isLoadingManifestList) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //
    //     //  Empty State
    //     // if (provider.manifestList.isEmpty) {
    //     //   return const Center(
    //     //     child: Text("No Manifests Found"),
    //     //   );
    //     // }
    //
    //     //  Data State
    //     return ListView.builder(
    //       padding: const EdgeInsets.only(top: 8, bottom: 20),
    //    //   itemCount: provider.manifestList.length,
    //       itemCount: 5,
    //       itemBuilder: (context, index) {
    //
    //      //   final item = provider.manifestList[index];
    //
    //         // return ManifestCard(
    //         //   location: "${item.hubName} (${item.hubCode})",
    //         //   manifestId: item.manifestId.toString(),         // updated
    //         //   driverName: item.driverText??"",
    //         //   date: item.manifestLoadDate??"",
    //         //   truckId: item.truckId?.toString() ?? "-",      // updated
    //         //   truckName: item.truckName??"",
    //         //   notes: item.trailerText??"",
    //         //
    //         //   stopsTotal: item.stopCount??0,
    //         //   stopsCompleted: item.completedStops??0,
    //         //   stopsPending: item.pendingStops??0,
    //         //
    //         //   ordersTotal: item.orderCount??0,
    //         //   ordersCompleted: item.completedOrders??0,        // updated
    //         //   ordersPending: item.pendingOrders??0,             // updated
    //         //
    //         //   actionText: widget.actionText,
    //         //   actionIcon: widget.actionIcon,
    //         //
    //         //   onActionTap: () {
    //         //     if (widget.onActionTap != null) {
    //         //       widget.onActionTap!(index);
    //         //     }
    //         //   },
    //         // );
    //
    //         return ManifestCard(
    //           location: "CO-DN",
    //           manifestId: "458921",
    //           driverName: "Jeffer Alonso Villamizar Cuellar (VTL",
    //           date: "2026-03-16",
    //           truckId: "TRK-1023",
    //           truckName: "T-OC02",
    //           notes: "Handle with care",
    //
    //           stopsTotal: 12,
    //           stopsCompleted: 7,
    //           stopsPending: 5,
    //
    //           ordersTotal: 40,
    //           ordersCompleted: 25,
    //           ordersPending: 15,
    //
    //           actionText: widget.actionText,
    //           actionIcon: widget.actionIcon,
    //
    //           onActionTap: () {
    //             if (widget.onActionTap != null) {
    //               widget.onActionTap!(index);
    //             }
    //           },
    //         );
    //
    //       },
    //     );
    //   },
    // );
  return  ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      //   itemCount: provider.manifestList.length,
      itemCount: 5,
      itemBuilder: (context, index) {

        //   final item = provider.manifestList[index];

        // return ManifestCard(
        //   location: "${item.hubName} (${item.hubCode})",
        //   manifestId: item.manifestId.toString(),         // updated
        //   driverName: item.driverText??"",
        //   date: item.manifestLoadDate??"",
        //   truckId: item.truckId?.toString() ?? "-",      // updated
        //   truckName: item.truckName??"",
        //   notes: item.trailerText??"",
        //
        //   stopsTotal: item.stopCount??0,
        //   stopsCompleted: item.completedStops??0,
        //   stopsPending: item.pendingStops??0,
        //
        //   ordersTotal: item.orderCount??0,
        //   ordersCompleted: item.completedOrders??0,        // updated
        //   ordersPending: item.pendingOrders??0,             // updated
        //
        //   actionText: widget.actionText,
        //   actionIcon: widget.actionIcon,
        //
        //   onActionTap: () {
        //     if (widget.onActionTap != null) {
        //       widget.onActionTap!(index);
        //     }
        //   },
        // );

        return ManifestCard(
          location: "CO-DN",
          manifestId: "458921",
          driverName: "Jeffer Alonso Villamizar Cuellar (VTL",
          date: "2026-03-16",
          truckId: "TRK-1023",
          truckName: "T-OC02",
          notes: "Handle with care",

          stopsTotal: 12,
          stopsCompleted: 7,
          stopsPending: 5,

          ordersTotal: 40,
          ordersCompleted: 25,
          ordersPending: 15,

          actionText: widget.actionText,
          actionIcon: widget.actionIcon,

          onActionTap: () {
            if (widget.onActionTap != null) {
              widget.onActionTap!(index);
            }
          },
        );

      },
    );
  }
}
