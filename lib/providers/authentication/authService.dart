import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'authService.g.dart';
part 'authService.freezed.dart';

final _baseUrl = environment['api_url'];

@freezed
class AuthState with _$AuthState {
  AuthState._();
  factory AuthState(
      {@Default(false) bool isAuthenticated,
      String? token,
      @Default({}) Map<String, dynamic> userData,
      @Default(false) bool isLoading,
      String? errorMessage}) = _AuthState;
}

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  AuthState build() {
    // Start with loading state
    tryAutoLogin();
    return AuthState(isLoading: true);
  }

  // Future<void> _initAuthState() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('auth_token');

  //     if (token != null) {
  //       state = state.copyWith(
  //         isAuthenticated: true,
  //         isLoading: false,
  //       );
  //     } else {
  //       state = state.copyWith(isLoading: false);
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Failed to initialize auth state',
  //     );
  //   }
  // }

  Future<void> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userDataString = prefs.getString('user_data');

      if (token != null) {
        final userData = userDataString != null
            ? json.decode(userDataString) as Map<String, dynamic>
            : <String, dynamic>{};
        state = state.copyWith(
            isAuthenticated: true,
            token: token,
            userData: userData,
            isLoading: false);

        print("DEBUG: tryAutoLogin user data: $userData");

        ref.read(postServiceProvider.notifier).getPosts();

        ref.read(appstateProvider.notifier).changeAppRoute('/');
        // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Map<String, dynamic> _parseUserDataFromToken(String token) {
  //   // decode and validate JWT token here and parse
  //   try {
  //     final parts = token.split('.');
  //     if (parts.length != 3) {
  //       throw Exception("Invalid JWT Token format");
  //     }

  //     // Decode payload
  //     final payload = parts[1];
  //     final normalizedPayload = base64Url.normalize(payload);
  //     final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

  //     print("DEBUG: Decoded payload: $decodedPayload");
  //     return json.decode(decodedPayload) as Map<String, dynamic>;
  //   } catch (e) {
  //     print('Error parsing JWT Token: $e');
  //     return {
  //       "id": null,
  //       "username": "",
  //       "email": "",
  //       "description": "",
  //       "profilePicUrl": "",
  //       "gamePoints": 0,
  //       "createdAt": DateTime.now(),
  //       "updatedAt": DateTime.now()
  //     };
  //   }
  // }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Example HTTP POST request (replace with your backend endpoint and body)
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print("DEBUG: Login response: $data");

        // get JWT Token
        final token = data['token'];

        // extract user data
        final userData = data['user'] ?? {};
        print("DEBUG: userDATA: $userData");

        // save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_data', json.encode(userData));

        state = state.copyWith(
            isAuthenticated: true, token: token, userData: userData);

        ref.read(postServiceProvider.notifier).getPosts();
        // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
        ref.read(appstateProvider.notifier).changeAppRoute('/');
        print('login complete with token: $token, and user: $userData');
        return true;
      } else {
        print("Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    try {
      // sign up from backend
      final response = await http.post(Uri.parse('$_baseUrl/api/auth/signup'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {'username': username, 'email': email, 'password': password}));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        // get JWT Token
        final token = data['token'];

        // extract user data
        final userData = data['user'] ?? {};

        // save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_data', json.encode(userData));

        state = state.copyWith(
            isAuthenticated: true, token: token, userData: userData);

        ref.read(postServiceProvider.notifier).getPosts();
        ref.read(appstateProvider.notifier).changeAppRoute('/');
        // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
        print('signup complete with token: $token');
        return true;
      } else {
        print("Status Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void updateToken(String token) {
    state = state.copyWith(token: token);
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_data');

      // reset auth state and app state
      state = AuthState();
      await ref.read(appstateProvider.notifier).logout();
    } catch (e) {
      print(e.toString());
    }
  }
}
