
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class BuildRowField extends StatefulWidget {
  const BuildRowField({
    required this.title,
    required this.subtitle,
    super.key, this.onTap,
  });
  final String title;
  final String subtitle;
  final Function()? onTap;

  @override
  State<BuildRowField> createState() => _BuildRowFieldState();
}

class _BuildRowFieldState extends State<BuildRowField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title,style:Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 5,),
          GestureDetector(
            onTap: widget.onTap,
            child: Text(widget.subtitle,style:Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700))
          ),
        ],
      ),
    );
  }
}

