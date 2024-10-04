import 'package:fitfoot/core/theme/text_style.dart';
import 'package:fitfoot/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme({required this.context});

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary, // Highlight primary actions
      primarySwatch: AppColors.primarySwatch,
      hintColor: AppColors.hint,
      shadowColor: AppColors.shadow,
      cardColor: AppColors.card,
      scaffoldBackgroundColor: AppColors.background, // Neutral background
      textTheme: TextThemes(context: context).darkTextTheme,
      primaryTextTheme: TextThemes(context: context).primaryTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 1, // Slight elevation for app bar distinction
        backgroundColor: AppColors.background,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.surface, // Ensure title visibility
        ),
        iconTheme: const IconThemeData(
          color:
              AppColors.surface, // Bright color for icons for better visibility
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary, // Consistent button colors
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, // Make FAB stand out
        foregroundColor: AppColors.surface,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary:
            AppColors.surface, // Ensures text/icons on primary are visible
        onSecondary:
            AppColors.background, // Ensures text/icons on secondary are visible
        onSurface:
            AppColors.secondary, // Ensures text/icons on surface are visible
        onBackground:
            AppColors.surface, // Ensures text/icons on background are visible
        brightness: Brightness.dark,
      ),
    );
  }
}
