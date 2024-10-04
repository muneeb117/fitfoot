import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../main/global.dart';
import '../../../main/navigation/routes/name.dart';
import '../../../utils/app_constant.dart';
import 'logout_button.dart';
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          backgroundColor: AppColors.card,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120.h,
                width: 250.w,
                child: Image.asset(
                  'assets/images/logout_icon_2.png',
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Are You Sure !',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              LogoutButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  await Global.storageServices
                      .remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login, (Route<dynamic> route) => false);
                },
                text: 'Logout',
                isIcon: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}
