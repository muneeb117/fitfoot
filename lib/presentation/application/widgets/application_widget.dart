import 'package:fitfoot/presentation/shoe_size/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/screens/home/home_screen.dart';
import '../../profile/screens/profile_screen.dart';

Widget buildPage(index) {
  List<Widget> widgets = [
    const HomeScreen(),
    const IntroductionScreen(),
    const ProfileScreen(),
  ];
  return widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "Home",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset(
        "assets/icons/home.svg",
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.srcIn),
      ),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/home.svg",
            colorFilter:
                const ColorFilter.mode(AppColors.background, BlendMode.srcIn),
          ),
        ),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Measurement",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset(
        "assets/icons/foot.svg",
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.srcIn)
      ),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/foot.svg",
            colorFilter:
                const ColorFilter.mode(AppColors.background, BlendMode.srcIn),
          ),
        ),
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "Profile",
    icon: SizedBox(
      height: 22.h,
      width: 22.w,
      child: SvgPicture.asset(
        "assets/icons/nav-icon-profile.svg",
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.srcIn),
      ),
    ),
    activeIcon: Container(
      width: 60.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.navIcon,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: SizedBox(
          height: 22.h,
          width: 22.w,
          child: SvgPicture.asset(
            "assets/icons/nav-icon-profile.svg",
            colorFilter:
                const ColorFilter.mode(AppColors.background, BlendMode.srcIn),
          ),
        ),
      ),
    ),
  ),
];
