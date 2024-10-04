import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/firebase_config.dart';
import '../../../../../core/global/widgets/gradient_shadow.dart';
import '../../../widgets/reusable_text.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import '../controller/register_controller.dart';
import '../../../../../core/global/widgets/reusable_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../../../widgets/build_text_field.dart';
import '../../../widgets/divider.dart';
import '../../../widgets/row_field.dart';
import '../../../widgets/third_party_plugins.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseConfig.logScreenView(screenClass: 'Register Screen');
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: GradientBackgroundScreen(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReusableTitleCard(
                        title: 'Let’s Sign Up',
                        subtitle: 'Please enter your details to get signup',
                        icon: 'assets/images/logo.png'),
                    SizedBox(height: 15.h),
                    BuildTextField(
                      text: 'Name',
                      textType: TextInputType.name,
                      iconName: 'person',
                      onValueChange: (value) =>
                          context.read<RegisterBloc>().add(NameEvent(value)),
                    ),
                    SizedBox(height: 12.h),
                    BuildTextField(
                      text: 'Email',
                      textType: TextInputType.emailAddress,
                      iconName: 'mail',
                      onValueChange: (value) =>
                          context.read<RegisterBloc>().add(EmailEvent(value)),
                    ),
                    SizedBox(height: 12.h),
                    BuildTextField(
                      text: 'Password',
                      textType: TextInputType.text,
                      iconName: 'lock',
                      onValueChange: (value) => context
                          .read<RegisterBloc>()
                          .add(PasswordEvent(value)),
                    ),
                    SizedBox(height: 12.h),
                    BuildTextField(
                      text: 'Confirm Password',
                      textType: TextInputType.text,
                      iconName: 'lock',
                      onValueChange: (value) => context
                          .read<RegisterBloc>()
                          .add(RePasswordEvent(value)),
                    ),
                    SizedBox(height: 20.h),
                    ReusableButton(
                      gradient: AppColors.secondaryGradient,
                      text: state.isLoading ? "Loading..." : "Sign Up",
                      onPressed: state.isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();

                              RegisterController().handleSignUp(context);
                            },
                      isLoading: state.isLoading,
                      isIcon: false,
                    ),
                    SizedBox(height: 5.h),
                    BuildRowField(
                      title: "Already have an account?",
                      subtitle: "Log in",
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                    ),
                    SizedBox(height: 20.h),
                    const BuildDivider(text: 'Or Sign Up with'),
                    SizedBox(height: 20.h),
                    const ThirdPartyPlugins(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
