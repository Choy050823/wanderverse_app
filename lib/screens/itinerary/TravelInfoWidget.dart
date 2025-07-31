import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanderverse_app/providers/models.dart';

class TravelInfoWidget extends StatelessWidget {
  final String duration;
  final String distance;
  final TravelMode mode;
  final String directionUrl;

  const TravelInfoWidget({
    super.key,
    required this.duration,
    required this.distance,
    this.mode = TravelMode.DRIVING,
    required this.directionUrl,
  });

  Future<void> _launchUrl() async {
    if (directionUrl.isEmpty) {
      return;
    }

    final Uri uri = Uri.parse(directionUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } else {
      print('Could not launch $directionUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    IconData iconData;
    switch (mode) {
      case TravelMode.WALKING:
        iconData = Icons.directions_walk;
        break;
      case TravelMode.DRIVING:
        iconData = Icons.directions_car;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(width: 16),
          // const Spacer(),
          TextButton(
            onPressed: directionUrl.isNotEmpty ? _launchUrl : null,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Directions',
                  style: TextStyle(
                    color: directionUrl.isNotEmpty
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(0.5),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: directionUrl.isNotEmpty
                      ? colorScheme.primary
                      : colorScheme.outline.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
