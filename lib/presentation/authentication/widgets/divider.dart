
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:   EdgeInsets.symmetric(horizontal: 40.0.w),
      child:  Row(
        children: [
           Expanded(child: Divider(thickness: 1.w,color: AppColors.surface,height: 1.h,)),
           SizedBox(width: 5.w,),
          Text(text,style: Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600)


          ),
           SizedBox(width: 5.w,),

          Expanded(child: Divider(thickness: 1.w,color: AppColors.surface,height: 1.h,)),
        ],
      ),
    );
  }
}
