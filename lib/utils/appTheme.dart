import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Professional Travel-Inspired Color Palette
  static const Color primaryBlue = Color(0xFF1A5F7A); // Sophisticated deep teal-blue
  static const Color secondaryTeal = Color(0xFF159895); // Refined teal
  static const Color tertiaryGreen = Color(0xFF57C5B6); // Lighter teal/turquoise
  static const Color accentAmber = Color(0xFFF7C35F); // Warm gold, less saturated
  
  // Neutral Colors - Professional Gray Scale
  static const Color darkGrey = Color(0xFF2D3142); // More sophisticated than pure black
  static const Color mediumGrey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFE5E7EB);
  static const Color backgroundLight = Color(0xFFF8FAFC); // Subtle off-white
  static const Color backgroundDark = Color(0xFF1F2937); // Not too dark, easier on eyes

  // Semantic Colors - Professional variants
  static const Color success = Color(0xFF34D399); // Softer green
  static const Color error = Color(0xFFF87171); // Softer red
  static const Color warning = Color(0xFFFBBF24);
  static const Color info = Color(0xFF60A5FA);

  // Sophisticated gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1A5F7A), Color(0xFF159895)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF57C5B6), Color(0xFFF7C35F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light Theme - Professional & Clean
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: primaryBlue,
      onPrimary: Colors.white,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      tertiary: tertiaryGreen,
      onTertiary: Colors.white,
      background: backgroundLight,
      onBackground: darkGrey,
      surface: Colors.white,
      onSurface: darkGrey,
      surfaceVariant: Color(0xFFF1F5F9), // Subtle grey for hover states
      onSurfaceVariant: darkGrey,
      outline: mediumGrey,
      error: error,
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF991B1B),
      shadow: Color(0x40000000),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: GoogleFonts.notoSansTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        color: darkGrey,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        color: darkGrey,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        color: darkGrey,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        color: darkGrey,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryBlue,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: lightGrey, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        side: const BorderSide(color: primaryBlue),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF1F5F9),
      disabledColor: lightGrey,
      selectedColor: primaryBlue,
      secondarySelectedColor: secondaryTeal,
      labelStyle: const TextStyle(fontSize: 14),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightGrey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      labelStyle: const TextStyle(
        color: mediumGrey,
        fontSize: 16,
      ),
      hintStyle: TextStyle(
        color: mediumGrey.withOpacity(0.7),
        fontSize: 16,
      ),
      errorStyle: const TextStyle(
        color: error,
        fontSize: 12,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: lightGrey,
      thickness: 1,
      space: 24,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: primaryBlue,
      unselectedLabelColor: mediumGrey,
      indicatorColor: primaryBlue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryBlue,
      unselectedItemColor: mediumGrey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  // Dark Theme - Professional & Elegant
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      primary: tertiaryGreen, // Lighter color better for dark mode
      onPrimary: Colors.white,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      tertiary: accentAmber,
      onTertiary: Colors.black,
      background: backgroundDark,
      onBackground: Colors.white,
      surface: const Color(0xFF2D3748), // Slightly lighter than background
      onSurface: Colors.white,
      surfaceVariant: const Color(0xFF374151), // For subtle contrast 
      onSurfaceVariant: const Color(0xFFE5E7EB),
      outline: const Color(0xFF9CA3AF),
      error: error,
      onError: Colors.white,
      errorContainer: const Color(0xFF7F1D1D).withOpacity(0.7),
      onErrorContainer: Colors.white,
      shadow: Colors.black,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.notoSansTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF2D3748),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF4B5563), width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shadowColor: Colors.black.withOpacity(0.3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: tertiaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: tertiaryGreen,
        side: const BorderSide(color: tertiaryGreen),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: tertiaryGreen,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF374151),
      disabledColor: const Color(0xFF4B5563),
      selectedColor: tertiaryGreen,
      secondarySelectedColor: secondaryTeal,
      labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF374151),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4B5563), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4B5563), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: tertiaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: error, width: 2),
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 16,
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 16,
      ),
      errorStyle: const TextStyle(
        color: error,
        fontSize: 12,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF4B5563),
      thickness: 1,
      space: 24,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: tertiaryGreen,
      unselectedLabelColor: Color(0xFF9CA3AF),
      indicatorColor: tertiaryGreen,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1F2937),
      selectedItemColor: tertiaryGreen,
      unselectedItemColor: Color(0xFF9CA3AF),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
