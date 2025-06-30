// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/utils/env.dart';

part 'gamePointService.g.dart';

final _baseUrl = environment['api_url'];

@riverpod
class GamePointService extends _$GamePointService {
  @override
  Future<int> build() {
    return getCurrentUserGamePoints();
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

  Future<int> getCurrentUserGamePoints() async {
    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }

      final userId = ref.read(authServiceProvider).userData['id'];
      final url = Uri.parse('$_baseUrl/api/game/points?userId=$userId');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        print("Failed to load game points. Status: ${response.statusCode}");
        return -1;
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return -1;
    }
  }

  Future<int> getUserGamePoints(String userId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }

      final url = Uri.parse('$_baseUrl/api/game/points?userId=$userId');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        print("Failed to load game points. Status: ${response.statusCode}");
        return -1;
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return -1;
    }
  }

  Future<void> addCurrentUserGamePoints(int gamePoint) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }
      final userId = ref.read(authServiceProvider).userData['id'];
      final url = Uri.parse('$_baseUrl/api/game/points?userId=$userId&gamePoint=$gamePoint');

      final response = await http.post(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");

      if (response.statusCode == 201) {
        // return int.parse(response.body);
        ref
            .read(userServiceProvider.notifier)
            .updateUserGamePointCount(int.parse(response.body));
      } else {
        print("Failed to load game points. Status: ${response.statusCode}");
        return;
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return;
    }
  }
}
