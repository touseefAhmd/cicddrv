import 'package:flutter/material.dart';

import '../utils/theme/theme.dart';
import 'mediapicker/media_picker_model.dart';

class ComplianceCard extends StatelessWidget {
  final String title;
  final String captureText;
  final List<MediaPickerResult> images;
  final VoidCallback? onTap;

  const ComplianceCard({
    super.key,
    required this.title,
    required this.captureText,
    this.images = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: AppTheme.cardBackgroundColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.labelColor(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        captureText,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.labelColor(context).withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.labelColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppTheme.cardBackgroundColor(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Thumbnails
              if (images.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: images.map((img) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            img.bytes,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      3,
                          (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 80,
                            height: 80,
                            color: AppTheme.labelColor(context).withOpacity(0.1),
                            child: Icon(
                              Icons.image,
                              size: 40,
                              color: AppTheme.labelColor(context).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
