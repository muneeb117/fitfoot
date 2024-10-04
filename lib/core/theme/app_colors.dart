import 'package:flutter/material.dart';

class AppColors {
  /// App primary color
  static const Color primary = Color(0xFFF86E53); // Primary gradient start
  static const Color tertiary = Color(0xFF7B61FF); // Primary gradient start

  /// App secondary color
  static const Color secondary = Color(0xFF64748B); // Updated background color

  /// App nav color
  static const Color nav = Color(0xFF0D0D0D);

  /// App navIcon color
  static const Color navIcon = Color(0xFF191919);

  static const Color unselected = Color(0xFF64748B);

  /// App error color
  static const Color error = Color(0xFFFF003C);

  /// App background color - set to white
  static const Color background = Color(0xFFFFFFFF); // White background

  /// App shadow color
  static const Color shadow = Color.fromRGBO(0, 0, 0, 0.0);

  /// App surface color - adjusted to light grey for contrast
  static const Color surface = Color(0xFF000000); // Light grey surface

  /// App disable color
  static const Color disable =
      Color(0xFFA0A4A8); // Grey color for disabled elements

  ///text field background color - lighter shade for visibility on white
  static const Color inActiveField =
      Color(0xFFE0E0E0); // Lighter grey for text fields

  /// App hint color - making it darker for visibility
  static const Color hint = Color(0xFF757575); // Darker grey for hints

  /// Extra card color - adjusted for better visibility on white
  static const Color card = Color(0xFFF0F0F0); // Very light grey for cards

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFFFF61DA), // Gradient start color
      Color(0xFFFFCA61), // Gradient end color
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFF7B61FF), // 2nd Gradient start color
      Color(0xFFFF61DA), // 2nd Gradient end color
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static MaterialColor primarySwatch = getColorFromHex(primary.value);

  static MaterialColor getColorFromHex(int hexValue) {
    Map<int, Color> colorMap = {
      50: Color(hexValue),
      100: Color(hexValue),
      200: Color(hexValue),
      300: Color(hexValue),
      400: Color(hexValue),
      500: Color(hexValue),
      600: Color(hexValue),
      700: Color(hexValue),
      800: Color(hexValue),
      900: Color(hexValue),
    };
    return MaterialColor(hexValue, colorMap);
  }
}
