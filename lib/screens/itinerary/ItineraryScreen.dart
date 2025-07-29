import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/screens/itinerary/DaySection.dart';
import 'package:wanderverse_app/screens/itinerary/ItineraryHeader.dart';
import 'package:wanderverse_app/utils/env.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agentic AI Trip Planner',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // TODO: Handle back navigation
        //   },
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_horiz),
        //     onPressed: () {
        //       // TODO: Handle more options
        //     },
        //   ),
        // ],
      ),
      body: const ItineraryBody(),
    );
  }
}

class ItineraryBody extends ConsumerStatefulWidget {
  const ItineraryBody({super.key});

  @override
  ConsumerState<ItineraryBody> createState() => _ItineraryBodyState();
}

class _ItineraryBodyState extends ConsumerState<ItineraryBody> {
  final _textController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  TripPlan? _tripPlan;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<String?> _getToken() async {
    // Try from state first
    final authState = ref.read(authServiceProvider);
    String? token = authState.token;

    // Fallback to SharedPreferences if null
    if (token == null) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('auth_token');
      ref.read(authServiceProvider.notifier).updateToken(token ?? "");
      print("Retrieved token from SharedPreferences: $token");
    }

    return token;
  }

  Future<Map<String, String>> get _headers async {
    final token = await _getToken();
    print("DEBUG: $token");
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<void> _sendItineraryRequest() async {
    final request = _textController.text.trim();
    if (request.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Encode the query parameter properly
      final encodedRequest = Uri.encodeComponent(request);
      final baseUrl = environment['api_url'];
      final url = Uri.parse(
        '$baseUrl/api/itinerary?userTripRequest=$encodedRequest',
      );

      print('Sending itinerary request to: $url');

      final response = await http.get(url, headers: await _headers);

      if (response.statusCode == 200) {
        // Parse the response
        final jsonData = json.decode(response.body);
        print(
          'Received response: ${response.body.substring(0, min(100, response.body.length))}...',
        );

        // Convert JSON to TripPlan object
        final tripPlan = TripPlan.fromJson(jsonData);

        setState(() {
          _tripPlan = tripPlan;
          _isLoading = false;
          // Clear the text field after successful request
          if (tripPlan.dailyItineraryList.isNotEmpty) {
            _textController.clear();
          }
        });
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        setState(() {
          _errorMessage =
              'Failed to generate itinerary: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Exception during API call: $e');
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
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
              _isLoading
                  ? Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: theme.colorScheme.onPrimary,
                      ),
                    )
                  : IconButton(
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

        // Error message if any
        if (_errorMessage != null)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: theme.colorScheme.onErrorContainer),
            ),
          ),

        // Display the trip plan if available
        if (_tripPlan != null) _buildTripPlanView(_tripPlan!),
        // else
        //   _buildPlaceholderView(theme),
      ],
    );
  }

  Widget _buildTripPlanView(TripPlan tripPlan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItineraryHeader(
          title: tripPlan.planTitle,
          startDate: tripPlan.tripStartDate,
          endDate: tripPlan.tripEndDate,
        ),

        // Overview section
        if (tripPlan.overview.isNotEmpty) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(tripPlan.overview),
                ],
              ),
            ),
          ),
        ],

        // Warnings section if any
        if (tripPlan.warnings.isNotEmpty) ...[
          const SizedBox(height: 16),
          Card(
            color: Theme.of(
              context,
            ).colorScheme.errorContainer.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Important Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...tripPlan.warnings.map(
                    (warning) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.warning_amber,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(warning)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Daily itineraries
        ...tripPlan.dailyItineraryList.map((daily) => _buildDaySection(daily)),
      ],
    );
  }

  Widget _buildDaySection(DailyItinerary dailyItinerary) {
    // Convert activities to ItineraryTimelineNodeData
    final items = <ItineraryTimelineNodeData>[];
    int index = 1;

    for (var i = 0; i < dailyItinerary.activityList.length; i++) {
      final activity = dailyItinerary.activityList[i];

      // Skip travel activities, we'll add them as travel info to the next destination
      if (activity.activityType == ActivityType.destination &&
          activity.locationDetails != null) {
        final location = activity.locationDetails!;

        // Check if there's a previous travel activity
        TravelDetails? travelDetails;
        if (i > 0 &&
            dailyItinerary.activityList[i - 1].activityType ==
                ActivityType.travel) {
          travelDetails = dailyItinerary.activityList[i - 1].travelDetails;
        }

        // Create additional info map for any extra details
        // final additionalInfo = <String, dynamic>{};
        // if (location.priceLevel != null) {
        //   additionalInfo['Price Level'] = '${'$'.repeat(location.priceLevel!)}';
        // }
        // if (location.types != null && location.types!.isNotEmpty) {
        //   additionalInfo['Types'] = location.types!.join(', ');
        // }
        // if (location.wheelchair != null) {
        //   additionalInfo['Wheelchair Accessible'] = location.wheelchair! ? 'Yes' : 'No';
        // }

        items.add(
          ItineraryTimelineNodeData(
            index: index++,
            title: location.name,
            description:
                location.editorialSummary ?? location.formattedAddress ?? '',
            time:
                '${activity.estimatedStartTime.hour}:${activity.estimatedStartTime.minute.toString().padLeft(2, '0')}',
            imageUrl:
                location.locationImageUrl ?? 'https://via.placeholder.com/100',
            travelDuration: travelDetails != null
                ? '${travelDetails.durationMinutes} min'
                : '',
            travelDistance: travelDetails != null
                ? '${travelDetails.distanceKm.toStringAsFixed(1)} km'
                : '',
            // Fix: Use lowercase travel mode values
            travelMode: travelDetails?.mode ?? TravelMode.DRIVING,
            // Add all location details
            address: location.formattedAddress,
            rating: location.rating,
            phoneNumber: location.phoneNumber,
            website: location.website,
            openingHours: location.openingHours,
            // additionalInfo: additionalInfo,
            locationUrl: location.locationUrl,
          ),
        );
      }
    }

    return DaySection(date: dailyItinerary.date, items: items);
  }

  Widget _buildPlaceholderView(ThemeData theme) {
    // Show a placeholder or sample itinerary when no real data is available
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItineraryHeader(
          title: 'Sample Itinerary',
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
              travelMode: TravelMode.DRIVING,
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
              travelMode: TravelMode.WALKING,
            ),
            // ... more items
          ],
        ),
      ],
    );
  }
}
