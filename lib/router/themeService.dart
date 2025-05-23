import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'themeService.g.dart';

@Riverpod(keepAlive: true)
class ThemeService extends _$ThemeService {
  static const String _themePreferenceKey = 'theme_mode';

  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  Future<void> _loadSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themePreferenceKey);

    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        default:
          state = ThemeMode.system;
          break;
      }
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _themePreferenceKey, newMode == ThemeMode.light ? 'light' : 'dark');
  }
}
