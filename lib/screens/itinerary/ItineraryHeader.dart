import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryHeader extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;

  const ItineraryHeader({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final String formattedDateRange =
        '${DateFormat('M/d').format(startDate)} - ${DateFormat('M/d').format(endDate)}';

    return Wrap(
      alignment: WrapAlignment.spaceBetween, // Similar to spaceBetween in Row
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 12, // Vertical space between lines
      spacing: 12, // Horizontal space between items
      children: [
        Text(
          title,
          style: textTheme.displaySmall,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize
                .min, // Important: don't take more space than needed
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                formattedDateRange,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
