import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/firebase_config.dart';
import '../../../../../core/global/widgets/gradient_shadow.dart';
import '../../../../../core/global/widgets/reusable_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../../../widgets/build_text_field.dart';
import '../../../widgets/divider.dart';
import '../../../widgets/reusable_text.dart';
import '../../../widgets/row_field.dart';
import '../../../widgets/third_party_plugins.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseConfig.logScreenView(screenClass: 'Login Screen');

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: GradientBackgroundScreen(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  const ReusableTitleCard(
                    title: 'Welcome back!',
                    subtitle: 'Please enter your details to get sign in',
                    icon: 'assets/images/logo.png',
                  ),
                  SizedBox(height: 30.h),
                  BuildTextField(
                    text: 'Email',
                    textType: TextInputType.emailAddress,
                    iconName: 'mail',
                    onValueChange: (value) {
                      context.read<LoginBloc>().add(EmailEvents(value));
                    },
                  ),
                  SizedBox(height: 12.h),
                  BuildTextField(
                    text: 'Password',
                    textType: TextInputType.text,
                    iconName: 'lock',
                    onValueChange: (value) {
                      context.read<LoginBloc>().add(PasswordEvents(value));
                    },
                  ),
                  SizedBox(height: 20.h),
                  ReusableButton(
                    gradient: AppColors.secondaryGradient,
                    text: state.isLoading ? "Loading..." : "Sign In",
                    onPressed: state.isLoading
                        ? null
                        : () {
                            // Dismiss the keyboard before proceeding with the sign-in
                            FocusScope.of(context).unfocus();

                            const SignInController()
                                .handleSignIn("email", context);
                          },
                    isLoading: state.isLoading,
                    isIcon: false,
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.forgetPassword);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 220.w),
                      child: Text(
                        'Forget Password?',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  BuildRowField(
                    title: "Don’t have an account?",
                    subtitle: "Sign up",
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                  ),
                  SizedBox(height: 20.h),
                  const BuildDivider(text: 'Or Login with'),
                  SizedBox(height: 20.h),
                  const ThirdPartyPlugins(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
