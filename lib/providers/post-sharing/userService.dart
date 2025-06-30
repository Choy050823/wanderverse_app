// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'userService.freezed.dart';
part 'userService.g.dart';

final _baseUrl = environment['api_url'];

@freezed
class UserState with _$UserState {
  UserState._();
  factory UserState(
      {User? user,
      @Default(false) bool isLoading,
      String? errorMessage}) = _UserState;
}

@Riverpod(keepAlive: true)
class UserService extends _$UserService {
  @override
  UserState build() {
    // getCurrentUser();
    return UserState();
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

  void _handleError(String message) {
    state = state.copyWith(isLoading: false, errorMessage: message);
  }

  DateTime _parseDateTime(String? dateString) {
    if (dateString == null) return DateTime.now();

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString");
      return DateTime.now();
    }
  }

  void getCurrentUser() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // final prefs = await SharedPreferences.getInstance();
      final storedUser = ref.watch(authServiceProvider).userData;

      if (storedUser.isEmpty) {
        print("EMPTY USER DATA FROM AUTH SERVICE!");
        return;
      }

      final userData = storedUser;
      final user = User(
          id: userData["id"].toString(),
          username: userData["username"],
          email: userData["email"],
          description: userData["description"],
          gamePoints: userData["gamePoints"],
          profilePicUrl: userData["profilePicUrl"] == "" ||
                  userData["profilePicUrl"] == null
              ? defaultProfilePic
              : userData["profilePicUrl"],
          createdAt: _parseDateTime(userData["createdAt"]),
          updatedAt: _parseDateTime(userData["updatedAt"]));

      print("User found: ${user.profilePicUrl}");

      state = state.copyWith(user: user, isLoading: false, errorMessage: null);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  // this get user method is settled without using state
  Future<User?> getUser(String userId) async {
    // if (state.isLoading) return;

    // state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }

      print("DEBUG: current user id: $userId");

      final url = Uri.parse('$_baseUrl/api/user/$userId');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print(data);

        final user = data
            .map((json) {
              try {
                return User(
                  id: json["id"].toString(),
                  username: json["username"],
                  email: json["email"],
                  description: json["description"],
                  profilePicUrl: json["profilePicUrl"],
                  createdAt: _parseDateTime(json["createdAt"]),
                  updatedAt: _parseDateTime(json["updatedAt"]),
                  gamePoints: json["gamePoints"],
                );
              } catch (e) {
                print("Error parsing user: $e");
                return null;
              }
            })
            .where((user) => user != null)
            .cast<User>();

        print("Fetched user: ${user.isEmpty ? "None" : "have"}");

        return user;

        // state = state.copyWith(user: user, isLoading: false);
      } else {
        print("Failed to load user. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return null;
    }
  }

  void clearUser() {
    state = state.copyWith(user: null, isLoading: false, errorMessage: null);
  }

  void updateUserGamePointCount(int change) {
    // Find the currentuser
    final user = state.user;

    if (user != null) {
      state = state.copyWith(user: state.user!.copyWith(gamePoints: change));
    }
  }

  // Create user handled by sign up, will see if needed to implement later
}
