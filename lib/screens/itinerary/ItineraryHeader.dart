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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: textTheme.displaySmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
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
