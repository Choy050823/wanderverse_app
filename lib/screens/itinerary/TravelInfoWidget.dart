import 'package:flutter/material.dart';
import 'package:wanderverse_app/providers/models.dart';

class TravelInfoWidget extends StatelessWidget {
  final String duration;
  final String distance;
  final TravelMode mode;

  const TravelInfoWidget({
    super.key,
    required this.duration,
    required this.distance,
    this.mode = TravelMode.driving,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    IconData iconData;
    switch (mode) {
      case TravelMode.walking:
        iconData = Icons.directions_walk;
        break;
      case TravelMode.driving:
        iconData = Icons.directions_car;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Row(
        children: [
          Icon(iconData, size: 18, color: colorScheme.outline),
          const SizedBox(width: 8),
          Text(
            '$duration · $distance',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Directions'),
                Icon(Icons.arrow_drop_down, color: colorScheme.outline),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
