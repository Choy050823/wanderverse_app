import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/itinerary/ItineraryCard.dart';

class ItineraryTimelineNode extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String time;
  final String imageUrl;
  final bool isLast;
  final String? address;
  final double? rating;
  final String? phoneNumber;
  final String? website;
  final List<String>? openingHours;
  final Map<String, dynamic>? additionalInfo;
  final String? locationUrl; // Add this field

  const ItineraryTimelineNode({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.time,
    required this.imageUrl,
    this.isLast = false,
    this.address,
    this.rating,
    this.phoneNumber,
    this.website,
    this.openingHours,
    this.additionalInfo,
    this.locationUrl, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Important: align to top
          children: [
            // Timeline circle and line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 40,
                // Don't constrain the height of this container
                child: Column(
                  children: [
                    // Circle with number
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
                    // Timeline line
                    // if (!isLast)
                    //   Container(
                    //     width: 2,
                    //     height:
                    //         100, // Just a starting height, will be painted over
                    //     color: colorScheme.outline.withOpacity(0.3),
                    //   ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Card content - must be Expanded to take remaining width
            Expanded(
              child: ItineraryCard(
                title: title,
                description: description,
                time: time,
                imageUrl: imageUrl,
                address: address,
                rating: rating,
                phoneNumber: phoneNumber,
                website: website,
                openingHours: openingHours,
                locationUrl: locationUrl,
              ),
            ),
          ],
        ),
        if (isLast) const SizedBox(height: 24),
      ],
    );
  }
}
