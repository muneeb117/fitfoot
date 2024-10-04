import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientShadowCircle extends StatelessWidget {
  final double size;

  const GradientShadowCircle({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withOpacity(0.5),
            blurRadius: 100.r,
            offset: Offset(1.w, 4.h),
            spreadRadius: 20.r,
          ),
          BoxShadow(
            color: const Color(0xFFFF61DA).withOpacity(0.5),
            blurRadius: 100.r,
            offset: Offset(1.w, 3.h),
            spreadRadius: 40.r,
          ),
        ],
      ),
    );

  }
}
class GradientBackgroundScreen extends StatelessWidget {
  final Widget child;
  const GradientBackgroundScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          child: GradientShadowCircle(size: 120,),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
