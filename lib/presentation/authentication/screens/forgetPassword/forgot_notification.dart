import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../main/navigation/routes/name.dart';

class ForgotNotificationScreen extends StatefulWidget {
  const ForgotNotificationScreen({super.key});

  @override
  State<ForgotNotificationScreen> createState() => _ForgotNotificationScreenState();
}

class _ForgotNotificationScreenState extends State<ForgotNotificationScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title:  Text("Password Reset",style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 100.h,),
            SizedBox(
              height: 100.h,
              child: Lottie.asset("assets/animations/email_sent.json"),
            ),
            SizedBox(height: 30.h),
            Text(
              "Email has been Sent to Your Account",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium
            ),
            SizedBox(height: 15.h),
            Text(
              "Please check your inbox and follow the instructions to reset your password.",
              textAlign: TextAlign.center,
              style:Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
