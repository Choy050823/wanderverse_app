import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appState.g.dart';
part 'appState.freezed.dart';

@freezed
class AppStateData with _$AppStateData {
  AppStateData._();
  factory AppStateData({
    @Default('/auth') String route,
    // @Default(false) bool isAuthenticated
  }) = _AppStateData;

  static const String home = '/';
  static const String auth = '/auth';
  static const String discussion = '/discussion';
  static const String profile = '/user-profile';
  static const String game = '/game';
  static const String itinerary = '/itinerary';
  static const String unknown = '/page-not-found';

  bool isValidRoute(String route) {
    return route == home ||
        route == auth ||
        route == discussion ||
        route == game ||
        route == itinerary ||
        route == profile;
  }
}

@Riverpod(keepAlive: true)
class Appstate extends _$Appstate {
  @override
  AppStateData build() {
    return AppStateData();
  }

  void changeAppRoute(String route) {
    if (route == AppStateData.unknown || state.isValidRoute(route)) {
      // Accept both valid routes and the special unknown route
      state = state.copyWith(route: route);
    } else {
      // Fallback for invalid routes (this should rarely be hit because parser handles it)
      state = state.copyWith(route: AppStateData.unknown);
    }
  }

  // void changeIsAuthenticated(bool isAuthenticated) {
  //   state = state.copyWith(isAuthenticated: isAuthenticated);
  // }

  Future<void> logout() async {
    state = state.copyWith(route: AppStateData.auth);
  }
}
