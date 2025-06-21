// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'destinationService.g.dart';

final _baseUrl = environment['api_url'];

@Riverpod(keepAlive: true)
class DestinationService extends _$DestinationService {
  @override
  Future<List<Destination>> build() async {
    return getDestinations();
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

  // void _handleError(String message) {
  //   state = [];
  // }

  DateTime _parseDateTime(String? dateString) {
    if (dateString == null) return DateTime.now();

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString");
      return DateTime.now();
    }
  }

  Future<List<Destination>> getDestinations() async {
    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }

      // print("DEBUG: current user id: $postId");

      final url = Uri.parse('$_baseUrl/api/destination');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // print(data);

        final List<Destination> destinations = data
            .map((destination) {
              try {
                return Destination(
                    id: destination["id"].toString(),
                    name: destination["name"],
                    description: destination["description"],
                    imageUrl: destination["imageUrl"],
                    createdAt: _parseDateTime(destination["createdAt"]),
                    updatedAt: _parseDateTime(destination["updatedAt"]));
              } catch (e) {
                print("Error parsing comment: ${e.toString()}");
                return null;
              }
            })
            .where((destination) => destination != null)
            .cast<Destination>()
            .toList();

        return destinations;
      } else {
        print("Failed to load user. Status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return [];
    }
  }
}
