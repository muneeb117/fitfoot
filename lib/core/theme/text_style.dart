import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const String fontFamily = 'PlusJakartaSans'; // Switched to Plus Jakarta Sans

  /// Text style for body
  static  TextStyle bodyLarge = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    height: 21.14 / 14,
    fontFamily: fontFamily,
  );

  static  TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    height: 21.14 / 14,
    fontFamily: fontFamily,
  );

  static  TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    height: 21.14 / 14,
    fontFamily: fontFamily,
  );

  /// Text style for title
  static  TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22.sp,
    height: 33.6 / 24,
    fontFamily: fontFamily,
  );

  static  TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    height: 21.6 / 18,
    fontFamily: fontFamily,
  );

  static  TextStyle titleSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    height: 20.16 / 16,
    fontFamily: fontFamily,
  );
}
