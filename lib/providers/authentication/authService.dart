import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'authService.g.dart';
part 'authService.freezed.dart';

final backend_url = environment['api_url'];

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
    _initAuthState();
    return AuthState(isLoading: true);
  }

  Future<void> _initAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize auth state',
      );
    }
  }

  Future<void> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token != null) {
        final userData = _parseUserDataFromToken(token);
        state = state.copyWith(
          isAuthenticated: true,
          token: token,
          userData: userData,
        );

        ref.read(appstateProvider.notifier).changeAppRoute('/');
        // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> _parseUserDataFromToken(String token) {
    // decode and validate JWT token here and parse
    return {'id': 'user123', 'username': 'John Doe', 'email': 'john@gmail.com'};
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Example HTTP POST request (replace with your backend endpoint and body)
      final response = await http.post(
        Uri.parse('$backend_url/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // get JWT Token
        final token = data['token'];

        // save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        print("Saved token: $token");

        state = state.copyWith(
            isAuthenticated: true,
            token: token,
            userData: _parseUserDataFromToken(token));

        // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
        ref.read(appstateProvider.notifier).changeAppRoute('/');
        print('login complete with token: $token');
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
      final response = await http.post(
          Uri.parse('$backend_url/api/auth/signup'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
              {'username': username, 'email': email, 'password': password}));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        // got JWT Token after finish sign up
        final token = data['token'];

        // save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        print("Saved token: $token");

        state = state.copyWith(
            isAuthenticated: true,
            token: token,
            userData: {'id': data['id'], 'username': username, 'email': email});

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

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      // reset auth state and app state
      state = AuthState();
      await ref.read(appstateProvider.notifier).logout();
    } catch (e) {
      print(e.toString());
    }
  }
}
