import 'package:flutter/material.dart';

class AppTheme {
  // 🔹 Common Label Text Style
  static const TextStyle labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // 🌟 Light Theme with Light Purple
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple[300], // Light Purple
    scaffoldBackgroundColor: Colors.white,

    // 🔹 AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[300], // Light Purple
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // 🔹 Icon Theme
    iconTheme: const IconThemeData(color: Colors.black),

    // 🔹 Text Theme
    textTheme: TextTheme(
      bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      bodyMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.purple[300]),
      labelLarge: labelStyle.copyWith(color: Colors.black),
    ),

    // 🔹 Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.purple[300], // Active item color
      unselectedItemColor: Colors.grey, // Inactive item color
      selectedLabelStyle: const TextStyle(color: Colors.purple),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
    ),

    // 🔹 Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[300], // Button color
        foregroundColor: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.purple[300], // Text color
        side: BorderSide(color: Colors.purple[300]!), // Border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.purple[300], // Text color
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );

  // 🌙 Dark Theme (Darker Purple)
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.purple[700], // Darker Purple
    scaffoldBackgroundColor: Colors.black,

    // 🔹 AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // 🔹 Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),

    // 🔹 Text Theme
    textTheme: TextTheme(
      bodyLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.purple[300]),
      labelLarge: labelStyle.copyWith(color: Colors.white),
    ),

    // 🔹 Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.purple[700], // Active item color
      unselectedItemColor: Colors.grey, // Inactive item color
      selectedLabelStyle: const TextStyle(color: Colors.purple),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
    ),

    // 🔹 Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[700], // Button color
        foregroundColor: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.purple[700], // Text color
        side: BorderSide(color: Colors.purple[700]!), // Border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.purple[700], // Text color
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
