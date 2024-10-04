import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class LogoutButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? buttonColor;
  final bool isEnabled;
  final bool isLoading;

  final bool isIcon;

  final Gradient? gradient;
  final String? iconAssetPath;

  const LogoutButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor,
    this.isLoading = false,
    this.isEnabled = true,
    this.gradient,
    required this.isIcon,
    this.iconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 42.h,
        decoration: BoxDecoration(
          color: Colors.red,
          // gradient: gradient,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isLoading
            ? Center(
          child: SizedBox(
              height: 14.h,
              width: 16.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.5.w,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.surface),
              )),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall!.copyWith(fontSize: 14.sp),
            ),
            SizedBox(
              width: 8.w,
            ),
            if (isIcon && iconAssetPath != null)
              SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: SvgPicture.asset(
                        iconAssetPath!),
                  ))
          ],
        ),
      ),
    );
  }
}
