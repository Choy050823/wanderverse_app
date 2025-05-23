import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Brand Colors - Travel Inspired
  static const Color primaryBlue = Color(0xFF1A73E8); // Sky blue
  static const Color secondaryTeal = Color(0xFF00BFA5); // Ocean/tropical
  static const Color accentSunshine = Color(0xFFFFB74D); // Warm sunshine
  static const Color accentCoral = Color(0xFFFF7043); // Coral/sunset

  // Neutral Colors
  static const Color darkGrey = Color(0xFF424242);
  static const Color mediumGrey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF303030);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Gradient colors - Sky to Ocean gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF00BFA5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: primaryBlue,
      onPrimary: Colors.white,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      tertiary: accentSunshine,
      onTertiary: Colors.black,
      background: backgroundLight,
      onBackground: darkGrey,
      surface: Colors.white,
      onSurface: darkGrey,
      error: error,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // Lighter app bar
      foregroundColor: primaryBlue, // Blue title for contrast
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: lightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryBlue),
      ),
    ),
  );

  // Dark Theme - Made lighter than before
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      primary: primaryBlue.withOpacity(0.9),
      onPrimary: Colors.white,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      tertiary: accentSunshine,
      onTertiary: Colors.black,
      background: const Color(0xFF303030), // Lighter dark mode
      onBackground: Colors.white,
      surface: const Color(0xFF424242), // Lighter surface
      onSurface: Colors.white,
      error: error,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF303030), // Lighter dark mode
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF424242), // Lighter app bar
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF424242), // Lighter card background
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentSunshine, // Brighter accent in dark mode
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF424242),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGrey.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGrey.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryBlue),
      ),
    ),
  );
}
