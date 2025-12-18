import 'package:flutter/material.dart';

class AppTheme {
  // Colores base
  static const Color lightBackground = Color(0xFFE5E5E5);
  static const Color darkBackground = Color(0xFF0A0A0A);

  static const Color primaryColor =
      Color(0xFF6C63FF); // Un violeta moderno y vibrante
  static const Color primaryDark = Color(0xFF8A84FF);

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.apply(fontFamily: 'Funnel Sans');
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: lightBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Funnel Sans',
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: darkBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Funnel Sans',
        ),
      ),
    );
  }
}
