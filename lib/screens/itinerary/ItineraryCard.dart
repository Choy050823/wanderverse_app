import 'package:flutter/material.dart';

class ItineraryCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String imageUrl;

  const ItineraryCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final chipTheme = Theme.of(context).chipTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.outline, height: 1.5),
                ),
                if (time.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Chip(
                    label: Text(time),
                    labelStyle: chipTheme.labelStyle?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: colorScheme.primary.withOpacity(0.1),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colorScheme.surfaceVariant,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: colorScheme.outline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}