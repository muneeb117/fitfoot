import 'package:fitfoot/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextThemes {
  BuildContext context;
  TextThemes({required this.context});

  /// Text theme
  TextTheme get darkTextTheme {
    return TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.surface,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.surface,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.surface,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.surface,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.surface,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.surface,
      ),
      labelLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.secondary,
      ),
      labelMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.secondary,
      ),
      labelSmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.secondary,
      ),
    );
  }

  /// Primary text theme
  TextTheme get primaryTextTheme {
    return TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.surface,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.surface,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.surface,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.surface,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.surface,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.surface,
      ),
      labelLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.surface.withOpacity(0.75),
      ),
      labelMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.surface.withOpacity(0.75),
      ),
      labelSmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.surface.withOpacity(0.75),
      ),
    );
  }
}
