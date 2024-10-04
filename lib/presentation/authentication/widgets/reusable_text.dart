import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableTitleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;

  const ReusableTitleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            icon,
            height: 80.h,
            width: 80.w,
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(

            ),
          ),
        ),
      ],
    );
  }
}
