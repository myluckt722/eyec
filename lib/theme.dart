import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00BFA5);
  static const Color secondary = Color(0xFF26C6DA);
  static const Color background = Color(0xFFF9FAFB);
  static const Color textDark = Color(0xFF263238);
  static const Color card = Colors.white;
  static const Color danger = Color(0xFFFF7043);
}

// Light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: Color(0xFF2BBDED),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textDark, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.textDark),
    titleLarge: TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.card,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey,
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212),
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  cardTheme: CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey,
  ),
);
