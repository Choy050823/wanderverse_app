import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/screens/itinerary/ItineraryTimelineNode.dart';
import 'package:wanderverse_app/screens/itinerary/TravelInfoWidget.dart';

// A simple data class to hold item data
class ItineraryTimelineNodeData {
  final int index;
  final String title;
  final String description;
  final String time;
  final String travelDuration;
  final String travelDistance;
  final String imageUrl;
  final TravelMode travelMode;
  final String? address;
  final double? rating;
  final String? phoneNumber;
  final String? website;
  final List<String>? openingHours;
  final Map<String, dynamic>? additionalInfo;
  final String? locationUrl;

  const ItineraryTimelineNodeData({
    required this.index,
    required this.title,
    required this.description,
    required this.time,
    required this.travelDuration,
    required this.travelDistance,
    required this.imageUrl,
    required this.travelMode,
    this.address,
    this.rating,
    this.phoneNumber,
    this.website,
    this.openingHours,
    this.additionalInfo,
    this.locationUrl,
  });
}

class DaySection extends StatelessWidget {
  final DateTime date;
  final List<ItineraryTimelineNodeData> items;

  const DaySection({super.key, required this.date, required this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        Text(
          DateFormat('EEEE, MMMM d').format(date),
          style: textTheme.headlineSmall?.copyWith(
            fontFamily: GoogleFonts.notoSans().fontFamily,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 12),
        ..._buildTimelineItems(),
      ],
    );
  }

  List<Widget> _buildTimelineItems() {
    final List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length;

      if (!isLast && item.travelDuration.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TravelInfoWidget(
              duration: item.travelDuration,
              distance: item.travelDistance,
              mode: item.travelMode,
              directionUrl: item.locationUrl ?? "",
            ),
          ),
        );
      }

      widgets.add(
        ItineraryTimelineNode(
          index: item.index,
          title: item.title,
          description: item.description,
          time: item.time,
          imageUrl: item.imageUrl,
          isLast: isLast,
          address: item.address,
          rating: item.rating,
          phoneNumber: item.phoneNumber,
          website: item.website,
          openingHours: item.openingHours,
        ),
      );
    }
    return widgets;
  }
}
