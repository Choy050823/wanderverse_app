import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/itinerary/ItineraryCard.dart';
import 'package:wanderverse_app/screens/itinerary/TimelinePainter.dart';

class ItineraryTimelineNode extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String time;
  final String imageUrl;
  final bool isLast;

  const ItineraryTimelineNode({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.time,
    required this.imageUrl,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned.fill(
                    top: 32,
                    child: CustomPaint(painter: TimelinePainter()),
                  ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  // Using the Card widget to automatically get the theme
                  child: ItineraryCard(
                    title: title,
                    description: description,
                    time: time,
                    imageUrl: imageUrl,
                  ),
                ),
                if (isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}