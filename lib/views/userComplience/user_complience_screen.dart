import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/complience_card.dart';
import '../../widgets/layout.dart';
import '../../widgets/mediapicker/media_picker_model.dart';
import '../../widgets/mediapicker/media_picker_provider.dart';
import '../../widgets/mediapicker/media_picker_widget.dart';


class DriverComplianceUIScreen extends StatefulWidget {
  final int manID;

  const DriverComplianceUIScreen({
    super.key,
    required this.manID,
  });

  @override
  State<DriverComplianceUIScreen> createState() => _DriverComplianceUIScreenState();
}

class _DriverComplianceUIScreenState extends State<DriverComplianceUIScreen> {
  // Track images for each card
  final Map<String, List<MediaPickerResult>> cardImages = {};

  @override
  void initState() {
    super.initState();
    cardImages['Driver License'] = [];
    cardImages['Vehicle Front'] = [];
    cardImages['Trailer Condition'] = [];
  }

  // Open MediaPicker on tap
  Future<void> _onCardTap(String title) async {
    final provider = context.read<MediaPickerProvider>();
    await provider.checkCameraAvailable();

    final pickedItems = await Navigator.push<List<MediaPickerResult>>(
      context,
      MaterialPageRoute(
        builder: (_) => MediaPickerWidget(
          config: MediaPickerConfig(
            mediaType: MediaType.image,
            source: MediaSource.camera,
            allowMultiple: true,
            maxItems: 5,
          ),
          onDone: (items) {
            Navigator.pop(context, items);
          },
        ),
      ),
    );

    if (pickedItems != null && pickedItems.isNotEmpty) {
      setState(() {
        cardImages[title] = pickedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      showBackArrow: true,
      title: "Driver Compliance",
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            ComplianceCard(
              title: "Driver License",
              captureText:
              "${cardImages['Driver License']?.length ?? 0} / 2 captured",
              images: cardImages['Driver License'] ?? [],
              onTap: () => _onCardTap("Driver License"),
            ),
            const SizedBox(height: 12),
            ComplianceCard(
              title: "Vehicle Front",
              captureText:
              "${cardImages['Vehicle Front']?.length ?? 0} / 3 captured",
              images: cardImages['Vehicle Front'] ?? [],
              onTap: () => _onCardTap("Vehicle Front"),
            ),
            const SizedBox(height: 12),
            ComplianceCard(
              title: "Trailer Condition",
              captureText:
              "${cardImages['Trailer Condition']?.length ?? 0} / 4 captured",
              images: cardImages['Trailer Condition'] ?? [],
              onTap: () => _onCardTap("Trailer Condition"),
            ),
          ],
        ),
      ),
    );
  }
}
