import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/widgets/gradient_shadow.dart';
import '../../../../core/global/widgets/reusable_button.dart';
import '../../../../core/global/widgets/toast_info.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../main/navigation/routes/name.dart';
import '../../widgets/build_text_field.dart';
import '../../widgets/reusable_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new)),
                const ReusableTitleCard(
                    title: 'Forget Password',
                    subtitle: 'Enter your email to reset your password',
                    icon: 'assets/images/logo.png'),
                SizedBox(
                  height: 50.h,
                ),
                BuildTextField(
                  text: "Email",
                  textType: TextInputType.emailAddress,
                  iconName: 'mail',
                  onValueChange: (value) {
                    emailController.text = value.toString();
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ReusableButton(
                  gradient: AppColors.secondaryGradient,
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      );
                      emailController.clear();
                      emailController.text = "";

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(
                            context, AppRoutes.forgetNotification);
                      });
                    } catch (e) {
                      showToast(msg: e.toString());
                    }
                  },
                  text: "Reset Password",
                  isIcon: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
