import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF1E1E1E);
  static const Color lightSecondary = Color(0xFF424242);
  static const Color lightAccent = Color(0xFFFF6B6B);
  
  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF121212);
  static const Color darkSecondary = Color(0xFF2C2C2C);
  static const Color darkAccent = Color(0xFF4ECDC4);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSecondary,
        tertiary: lightAccent,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[100],
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: lightPrimary),
        titleTextStyle: TextStyle(
          color: lightPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Roboto'),
        bodyMedium: TextStyle(fontFamily: 'Roboto'),
      ),
    );
  }

 static ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkPrimary, // nền chính
    cardColor: const Color(0xFF1E1E1E),    // nền của ListTile / Card
    dividerColor: Colors.grey.shade700,    // màu Divider
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: darkAccent),
      titleTextStyle: TextStyle(
        color: darkAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,       
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      collapsedBackgroundColor: const Color(0xFF1A1A1A),
      textColor: darkAccent,
      collapsedTextColor: Colors.grey[400],
      iconColor: darkAccent,
      collapsedIconColor: Colors.grey[400],
    ),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xFF1E1E1E),
      textColor: Colors.white,
      iconColor: darkAccent,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(darkAccent),
      trackColor: MaterialStateProperty.all(darkAccent.withOpacity(0.4)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
      bodyMedium: TextStyle(color: Colors.white70, fontFamily: 'Roboto'),
    ),
    dialogBackgroundColor: const Color(0xFF1E1E1E),
    colorScheme: const ColorScheme.dark(
      primary: darkAccent,
      secondary: darkSecondary,
      tertiary:Color(0xFF1E1E1E),
    ),
  );
}

}

class AppConstants {
  static const double buttonSpacing = 12.0;
  static const double buttonBorderRadius = 16.0;
  static const double displayBorderRadius = 24.0;
  static const double screenPadding = 24.0;
  static const int buttonPressDuration = 200;
  static const int modeSwitchDuration = 300;
}