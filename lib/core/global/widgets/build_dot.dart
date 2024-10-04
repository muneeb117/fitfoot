import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

AnimatedContainer buildDot(int index, int currentPage) {
  double baseHeight = 4.0.h;
  double baseWidth = 4.0.h;
  double selectedWidth = 16.0.w;

  if (ScreenUtil().screenWidth > 360) {
    baseHeight = 5.0.h;
    baseWidth = 5.0.h;
    selectedWidth = 20.0.w;
  }

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: EdgeInsets.only(right: 5.w),
    height: baseHeight,
    width: currentPage == index ? selectedWidth : baseWidth,
    decoration: BoxDecoration(
      color: currentPage == index
          ? AppColors.surface.withOpacity(0.8)
          : AppColors.hint,
      borderRadius: BorderRadius.circular(baseHeight / 2),
    ),
  );
}
