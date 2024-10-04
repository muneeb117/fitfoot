import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/app_colors.dart';

class BuildTextField extends StatefulWidget {
  final String text;
  final TextInputType? textType;

  final String iconName;
  final bool isPhoneNumber;
  final Function(String)? onValueChange; // Callback for value change

  const BuildTextField({
    super.key,
    required this.text,
    required this.textType,
    this.iconName = '',
    this.isPhoneNumber = false,
    this.onValueChange,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late bool _obscureText;
  late bool _isPasswordField;
  final TextEditingController _textController =
      TextEditingController(); // Text controller
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isPasswordField =
        widget.text == "Password" || widget.text == "Confirm Password";
    _obscureText = _isPasswordField;
    _focusNode.addListener(() {
      setState(() {}); // Rebuild to reflect focus changes in UI
    });

  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;


    return Container(
      width: 325.w,
      padding: const EdgeInsets.all(1.76),
      decoration: BoxDecoration(
        color: isFocused?null:AppColors.card,
        gradient: isFocused
            ? AppColors.secondaryGradient
            : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                keyboardType: widget.textType,
                obscureText: _obscureText,
                decoration: InputDecoration(
        
                  prefixIcon: widget.iconName.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 17.w, right: 10.w,top: 2.h),
                          child: SvgPicture.asset("assets/icons/${widget.iconName}.svg",
                              colorFilter:ColorFilter.mode(isFocused ? AppColors.surface : AppColors.secondary, BlendMode.srcIn),
                              width: 16.w, height: 16.h),
                        )
                      : null,
                  hintText: widget.text,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: _isPasswordField
                      ? GestureDetector(
                          onTap: _togglePasswordVisibility,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _obscureText ? AppColors.secondary : AppColors.surface,
                            size: 16.sp,
                          ),
                        )
                      : null,
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) {
                  if (widget.isPhoneNumber) {
                  } else {
                    widget.onValueChange?.call(value);
                  }
                },
              ),
            )
          ],
        ),
            ),
      );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  void dispose() {
    _textController.dispose();

    _focusNode.dispose();
    super.dispose();
  }


}
