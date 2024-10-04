import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagesBackground extends StatelessWidget {
  final Widget child;
  const PagesBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            bottom: 200.h,
            right: -175,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: 250.w,
                height: 250.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2D6DA5),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100.h,
            left: -175,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: 250.w,
                height: 250.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2D6DA5),
                ),
              ),
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.25),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
