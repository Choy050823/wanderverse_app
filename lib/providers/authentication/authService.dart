import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/router/appState.dart';

part 'authService.g.dart';
part 'authService.freezed.dart';

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
      // login from backend
      // get JWT Token
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyMTIzIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ';

      // save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      state = state.copyWith(
          isAuthenticated: true,
          token: token,
          userData: _parseUserDataFromToken(token));

      // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
      ref.read(appstateProvider.notifier).changeAppRoute('/');
      print('login complete');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    try {
      // sign up from backend

      // got JWT Token after finish sign up
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyMTIzIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ';

      // save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      state = state.copyWith(isAuthenticated: true, token: token, userData: {
        'id': 'id from backend',
        'username': username,
        'email': email
      });

      ref.read(appstateProvider.notifier).changeAppRoute('/');
      // ref.read(appstateProvider.notifier).changeIsAuthenticated(true);
      return true;
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
