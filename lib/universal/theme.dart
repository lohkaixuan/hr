import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle small = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle medium = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const TextStyle large = TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
}

class AppTheme {
  // 🔹 Common Rounded Shape
  static final RoundedRectangleBorder commonRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  // 🔹 Button TextStyle
  static const TextStyle buttonTextStyle = AppTextStyles.small;

  // 🔹 Shared Button Styles Generator
  static ButtonStyle elevatedButtonStyle(Color bgColor, Color fgColor) =>
      ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: commonRoundedShape,
        textStyle: buttonTextStyle,
      );

  static ButtonStyle outlinedButtonStyle(Color color) =>
      OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        shape: commonRoundedShape,
        textStyle: buttonTextStyle,
      );

  static ButtonStyle textButtonStyle(Color color) =>
      TextButton.styleFrom(
        foregroundColor: color,
        textStyle: buttonTextStyle,
      );

  // 🔹 Shared Bottom Nav Label Style
  static TextStyle bottomNavLabelStyle(Color color) =>
      AppTextStyles.small.copyWith(color: color);

  // 🌞 Light Theme
  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    primary: Colors.purple[300]!,
    bgColor: Colors.white,
    textColor: Colors.black,
    fadedTextColor: Colors.black,
  );

  // 🌙 Dark Theme
  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    primary: Colors.purple[700]!,
    bgColor: Colors.black,
    textColor: Colors.white,
    fadedTextColor: Colors.white70,
  );

  // 🔧 Theme Builder
  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color bgColor,
    required Color textColor,
    required Color fadedTextColor,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: bgColor,

      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light ? primary : bgColor,
        titleTextStyle: AppTextStyles.large.copyWith(color: textColor),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      iconTheme: IconThemeData(color: textColor),

      textTheme: TextTheme(
        bodyMedium: AppTextStyles.small.copyWith(color: fadedTextColor),
        bodyLarge: AppTextStyles.medium.copyWith(color: textColor),
        titleLarge: AppTextStyles.large.copyWith(color: primary),
        labelLarge: AppTextStyles.small.copyWith(color: textColor),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: bottomNavLabelStyle(Colors.purple),
        unselectedLabelStyle: bottomNavLabelStyle(Colors.grey),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonStyle(primary, Colors.white),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlinedButtonStyle(primary),
      ),

      textButtonTheme: TextButtonThemeData(
        style: textButtonStyle(primary),
      ),
    );
  }
}
