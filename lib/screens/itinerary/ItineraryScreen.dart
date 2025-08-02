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
    if (request.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final encodedRequest = Uri.encodeComponent(request);
      final baseUrl = environment['api_url'];
      final url = Uri.parse(
        '$baseUrl/api/itinerary?userTripRequest=$encodedRequest',
      );

      print('Sending itinerary request to: $url');
      final response = await http.get(url, headers: await _headers);

      if (response.statusCode == 200) {
        try {
          // Store response data for debugging
          final responseBody = response.body;
          print('Response length: ${responseBody.length}');

          // Step 1: Safely parse JSON
          Map<String, dynamic> jsonData;
          try {
            jsonData = json.decode(responseBody) as Map<String, dynamic>;
          } catch (e) {
            throw Exception('Failed to decode JSON: $e');
          }

          // Step 2: Safely convert JSON to TripPlan with manual field validation
          TripPlan? tripPlan;
          try {
            // Validate required fields first
            if (!jsonData.containsKey('planTitle') ||
                !jsonData.containsKey('tripStartDate') ||
                !jsonData.containsKey('tripEndDate') ||
                !jsonData.containsKey('dailyItineraryList')) {
              throw Exception('Missing required fields in response');
            }

            // Create dates safely
            final DateTime startDate = DateTime.parse(
              jsonData['tripStartDate'].toString(),
            );
            final DateTime endDate = DateTime.parse(
              jsonData['tripEndDate'].toString(),
            );

            // Process dailyItineraryList with special handling for types
            final List<dynamic> dailyListJson =
                jsonData['dailyItineraryList'] as List<dynamic>;
            final List<DailyItinerary> dailyList = [];

            for (final dayJson in dailyListJson) {
              // Fix any type issues in the day JSON before parsing
              final Map<String, dynamic> fixedDayJson =
                  Map<String, dynamic>.from(dayJson as Map);

              // Ensure warnings is a string (common issue)
              if (fixedDayJson['warnings'] != null &&
                  !(fixedDayJson['warnings'] is String)) {
                fixedDayJson['warnings'] = fixedDayJson['warnings'].toString();
              }

              // Process activities with special handling for location details
              if (fixedDayJson.containsKey('activityList')) {
                final List<dynamic> activityListJson =
                    fixedDayJson['activityList'] as List<dynamic>;
                final List<Map<String, dynamic>> fixedActivityList = [];

                for (final activityJson in activityListJson) {
                  final Map<String, dynamic> fixedActivityJson =
                      Map<String, dynamic>.from(activityJson as Map);

                  // Handle locationDetails type issues
                  if (fixedActivityJson.containsKey('locationDetails')) {
                    final locationDetails =
                        fixedActivityJson['locationDetails'];
                    if (locationDetails != null) {
                      // Create a clean copy without unexpected fields
                      final Map<String, dynamic> cleanLocationDetails = {};
                      final Map<String, dynamic> origLocationDetails =
                          Map<String, dynamic>.from(locationDetails as Map);

                      // Only include fields we expect in our model
                      if (origLocationDetails.containsKey('placeId')) {
                        cleanLocationDetails['placeId'] =
                            origLocationDetails['placeId'];
                      }
                      if (origLocationDetails.containsKey('name')) {
                        cleanLocationDetails['name'] =
                            origLocationDetails['name'];
                      }
                      if (origLocationDetails.containsKey('editorialSummary')) {
                        cleanLocationDetails['editorialSummary'] =
                            origLocationDetails['editorialSummary'];
                      }
                      if (origLocationDetails.containsKey('formattedAddress')) {
                        cleanLocationDetails['formattedAddress'] =
                            origLocationDetails['formattedAddress'];
                      }
                      if (origLocationDetails.containsKey('openingHours')) {
                        cleanLocationDetails['openingHours'] =
                            origLocationDetails['openingHours'];
                      }
                      if (origLocationDetails.containsKey('rating')) {
                        cleanLocationDetails['rating'] =
                            origLocationDetails['rating'];
                      }
                      if (origLocationDetails.containsKey('website')) {
                        cleanLocationDetails['website'] =
                            origLocationDetails['website'];
                      }
                      if (origLocationDetails.containsKey('phoneNumber')) {
                        cleanLocationDetails['phoneNumber'] =
                            origLocationDetails['phoneNumber'];
                      }
                      if (origLocationDetails.containsKey('locationUrl')) {
                        cleanLocationDetails['locationUrl'] =
                            origLocationDetails['locationUrl'];
                      }
                      if (origLocationDetails.containsKey('locationImageUrl')) {
                        cleanLocationDetails['locationImageUrl'] =
                            origLocationDetails['locationImageUrl'];
                      }

                      fixedActivityJson['locationDetails'] =
                          cleanLocationDetails;
                    }
                  }

                  fixedActivityList.add(fixedActivityJson);
                }

                fixedDayJson['activityList'] = fixedActivityList;
              }

              try {
                dailyList.add(DailyItinerary.fromJson(fixedDayJson));
              } catch (e) {
                print('Error parsing daily itinerary: $e');
                // Skip this day rather than failing everything
              }
            }

            // Create the TripPlan with the cleaned data
            tripPlan = TripPlan(
              planTitle: jsonData['planTitle']?.toString() ?? 'Itinerary Plan',
              overview: jsonData['overview']?.toString() ?? '',
              warnings:
                  (jsonData['warnings'] as List<dynamic>?)?.cast<String>() ??
                  [],
              tripStartDate: startDate,
              tripEndDate: endDate,
              dailyItineraryList: dailyList,
            );
          } catch (parseError) {
            print('Error in TripPlan manual parsing: $parseError');
            rethrow;
          }

          setState(() {
            _tripPlan = tripPlan;
            _isLoading = false;
            if (tripPlan!.dailyItineraryList.isNotEmpty) {
              _textController.clear();
            }
          });
        } catch (parseError) {
          print('Error parsing response: $parseError');
          setState(() {
            _errorMessage =
                'Failed to process the itinerary. Please try again.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Server error (${response.statusCode}). Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Connection error. Please check your internet and try again.';
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
        // if (tripPlan.overview.isNotEmpty) ...[
        //   const SizedBox(height: 16),
        //   Card(
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Overview',
        //             style: Theme.of(context).textTheme.titleLarge,
        //           ),
        //           const SizedBox(height: 8),
        //           Text(tripPlan.overview),
        //         ],
        //       ),
        //     ),
        //   ),
        // ],

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
}
