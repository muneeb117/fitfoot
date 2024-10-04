// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../../core/global/widgets/toast_info.dart';
// import '../../../../../data/repositories/device_repository.dart';
// import '../../../../../main/global.dart';
// import '../../../../../main/navigation/routes/name.dart';
// import '../../../../../utils/app_constant.dart';
// import '../bloc/login_bloc.dart';
// import '../bloc/login_event.dart';
// import 'package:flutter/material.dart';
//
// class SignInController {
//   const SignInController();
//
//   Future<void> handleSignIn(String type, BuildContext context) async {
//     final loginBloc = context.read<LoginBloc>();
//     loginBloc.add(LoginLoadingEvent(true));
//
//     try {
//       if (type == "email") {
//         final state = context.read<LoginBloc>().state;
//         String emailAddress = state.email;
//         String password = state.password;
//
//         List<String> errors = [];
//
//         if (emailAddress.isEmpty) {
//           errors.add("Email must be filled in");
//           loginBloc.add(LoginLoadingEvent(false));
//         }
//
//         if (state.password.isEmpty) {
//           errors.add("Password must be filled in");
//           loginBloc.add(LoginLoadingEvent(false));
//         }
//
//         if (errors.isNotEmpty) {
//           showToast(msg: errors.join(' and '));
//           loginBloc.add(LoginLoadingEvent(false));
//           return;
//         }
//
//         UserCredential credential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(
//             email: emailAddress, password: password);
//         User? user = credential.user;
//
//         if (user != null && !user.emailVerified) {
//           showToast(msg: "Please verify your email address to log in.");
//           loginBloc.add(LoginLoadingEvent(false));
//           return;
//         } else if (user == null) {
//           showToast(msg: "Login failed. Please check your credentials.");
//           loginBloc.add(LoginLoadingEvent(false));
//           return;
//         }
//
//         String? token = await user.getIdToken();
//         await Global.storageServices
//             .setString(AppConstants.STORAGE_USER_TOKEN_KEY, token!);
//         loginBloc.add(LoginCredentialsClearedEvent());
//
//         final deviceRepository = DeviceRepository();
//         String deviceId = await deviceRepository.getDeviceId();
//         final deviceInfo = await deviceRepository.getDeviceInfo(deviceId);
//
//         if (deviceInfo == null) {
//           // Save device info if it doesn't exist
//           await deviceRepository.saveDeviceInfo(deviceId, user.uid);
//           Navigator.pushNamedAndRemoveUntil(
//               context, AppRoutes.trail, (route) => false);
//         } else if (!(deviceInfo['trialActive'] as bool)) {
//           // Trial has ended, redirect to the trial end screen
//           Navigator.pushNamedAndRemoveUntil(
//               context, AppRoutes.trailEnd, (route) => false);
//         } else if (await deviceRepository.isTrialEnded(deviceId)) {
//           // If the trial has ended, update the status and redirect
//           await deviceRepository.updateDeviceTrialStatus(deviceId, false);
//
//           // Check if the user has already seen the trial end screen
//           bool hasSeenTrialEndScreen =
//           Global.storageServices.hasSeenTrialEndScreen();
//           if (!hasSeenTrialEndScreen) {
//             await Global.storageServices.setHasSeenTrialEndScreen(true);
//             Navigator.pushNamedAndRemoveUntil(
//                 context, AppRoutes.trailEnd, (route) => false);
//           } else {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, AppRoutes.application, (route) => false);
//           }
//         } else {
//           // If the trial is still active, proceed to the main application
//           Navigator.pushNamedAndRemoveUntil(
//               context, AppRoutes.application, (route) => false);
//         }
//       }
//       loginBloc.add(LoginLoadingEvent(false));
//     } on FirebaseAuthException catch (e) {
//       _handleFirebaseAuthException(e, loginBloc);
//     }
//   }
//
//   void _handleFirebaseAuthException(
//       FirebaseAuthException e, LoginBloc loginBloc) {
//     if (e.code == "user-not-found") {
//       showToast(msg: "No user found for that email");
//       loginBloc.add(LoginLoadingEvent(false));
//     } else if (e.code == "wrong-password") {
//       showToast(msg: "Incorrect password provided for that user");
//       loginBloc.add(LoginLoadingEvent(false));
//     } else if (e.code == "invalid-email") {
//       showToast(msg: "The email address is not in a valid format");
//       loginBloc.add(LoginLoadingEvent(false));
//     } else {
//       showToast(msg: "An error occurred: ${e.message}");
//       loginBloc.add(LoginLoadingEvent(false));
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/global/widgets/toast_info.dart';
import '../../../../../main/global.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../../../../../utils/app_constant.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';

class SignInController {
  const SignInController();

  Future<void> handleSignIn(String type, BuildContext context) async {
    final loginBloc = context.read<LoginBloc>();
    loginBloc.add(LoginLoadingEvent(true));

    try {
      if (type == "email") {
        final state = context.read<LoginBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        List<String> errors = [];

        if (emailAddress.isEmpty) {
          errors.add("Email must be filled in");
        }

        if (state.password.isEmpty) {
          errors.add("Password must be filled in");
        }

        if (errors.isNotEmpty) {
          if (!context.mounted) return;
          showToast(msg: errors.join(' and '));
          loginBloc.add(LoginLoadingEvent(false));
          return;
        }

        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        User? user = credential.user;

        if (user != null && !user.emailVerified) {
          if (!context.mounted) return;
          showToast(msg: "Please verify your email address to log in.");
          loginBloc.add(LoginLoadingEvent(false));
          return;
        } else if (user == null) {
          if (!context.mounted) return;
          showToast(msg: "Login failed. Please check your credentials.");
          loginBloc.add(LoginLoadingEvent(false));
          return;
        }

        String? token = await user.getIdToken();
        await Global.storageServices
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, token!);
        loginBloc.add(LoginCredentialsClearedEvent());


        if (!context.mounted) return;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.application, (route) => false);

      }
      if (context.mounted) {
        loginBloc.add(LoginLoadingEvent(false));
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _handleFirebaseAuthException(e, loginBloc);
      }
    }
  }

  // Handle Firebase Authentication errors
  void _handleFirebaseAuthException(
      FirebaseAuthException e, LoginBloc loginBloc) {
    if (e.code == "user-not-found") {
      showToast(msg: "No user found for that email");
    } else if (e.code == "wrong-password") {
      showToast(msg: "Incorrect password provided for that user");
    } else if (e.code == "invalid-email") {
      showToast(msg: "The email address is not in a valid format");
    } else {
      showToast(msg: "An error occurred: ${e.message}");
    }
    loginBloc.add(LoginLoadingEvent(false));
  }
}
