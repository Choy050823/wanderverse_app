import 'package:flutter/material.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/screens/itinerary/DaySection.dart';
import 'package:wanderverse_app/screens/itinerary/ItineraryHeader.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Osaka Trip'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // TODO: Handle back navigation
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // TODO: Handle more options
            },
          ),
        ],
      ),
      body: const ItineraryBody(),
    );
  }
}

class ItineraryBody extends StatefulWidget {
  const ItineraryBody({super.key});

  @override
  State<ItineraryBody> createState() => _ItineraryBodyState();
}

class _ItineraryBodyState extends State<ItineraryBody> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendItineraryRequest() {
    final request = _textController.text;
    if (request.isNotEmpty) {
      // TODO: Implement your backend call here
      print('Sending itinerary request: $request');
      // Optionally, clear the text field after sending
      // _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        const SizedBox(height: 16),
        // New Itinerary Request Input Row
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'e.g., "3 days in Tokyo with kids"',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: theme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: theme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _sendItineraryRequest(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send_rounded),
                onPressed: _sendItineraryRequest,
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        ItineraryHeader(
          title: 'Itinerary',
          startDate: DateTime(2024, 12, 27),
          endDate: DateTime(2025, 1, 4),
        ),
        const SizedBox(height: 24),
        DaySection(
          date: DateTime(2024, 12, 27),
          items: const [
            ItineraryTimelineNodeData(
              index: 1,
              title: 'Kansai International Airport',
              description:
                  'From the web: Serving the greater Osaka area, this hub on a man-made island has rail access & an adjacent hotel.',
              time: '5:00 PM',
              travelDuration: '2 hr 30 min',
              travelDistance: '56.9 mi',
              imageUrl:
                  'https://images.unsplash.com/photo-1587049352852-252077526367?q=80&w=2070&auto=format&fit=crop',
              travelMode: TravelMode.driving,
            ),
            ItineraryTimelineNodeData(
              index: 2,
              title: 'Okonomiyaki Katsu',
              description:
                  'Open 6-9PM • Compact restaurant with griddle tables for cook-your-own pancakes with savory fillings.',
              time: '',
              travelDuration: '28 min',
              travelDistance: '1.4 mi',
              imageUrl:
                  'https://images.unsplash.com/photo-1598867027375-86a0845a27e8?q=80&w=1974&auto=format&fit=crop',
              travelMode: TravelMode.walking,
            ),
            ItineraryTimelineNodeData(
              index: 3,
              title: 'Utano Youth Hostel',
              description:
                  'From the web: Utilitarian dorms & private rooms in a laid-back lodging offering a cafeteria & a tennis court.',
              time: '7:00 PM',
              travelDuration: '',
              travelDistance: '',
              imageUrl:
                  'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?q=80&w=2070&auto=format&fit=crop',
              travelMode: TravelMode.driving,
            ),
          ],
        ),
      ],
    );
  }
}
