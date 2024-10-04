import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/global/widgets/toast_info.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import 'authentication_controller.dart';

class RegisterController {
  late AuthenticationController authenticationController;

  RegisterController() {
    authenticationController = AuthenticationController();
  }

  Future<void> handleSignUp(BuildContext context) async {
    context.read<RegisterBloc>().add(RegisterLoadingEvent(true));

    final state = context.read<RegisterBloc>().state;
    if (!validateInputs(state, context)) {
      return;
    }

    try {
      await authenticationController.signUp(
        state.email,
        state.password,
        state.name,
        context,
      );
    } catch (e) {
      showToast(msg: "Failed to create account: ${e.toString()}");
    }
  }

  bool validateInputs(RegisterState state, BuildContext context) {
    if (state.email.isEmpty &&
        state.name.isEmpty &&
        state.password.isEmpty &&
        state.rePassword.isEmpty) {
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
      showToast(msg: "Please fill all fields.");
      return false;
    }

    List<String> errors = [];

    if (state.email.isEmpty) {
      errors.add("You need to fill in the email address.");
    } else if (!isValidEmail(state.email)) {
      errors.add("Invalid email format.");
    }

    if (state.name.isEmpty) {
      errors.add("You need to write your name.");
    }

    if (state.password.isEmpty) {
      errors.add("You need to fill in the password.");
    }

    if (state.rePassword.isEmpty) {
      errors.add("Password confirmation is empty.");
    } else if (state.rePassword != state.password) {
      errors.add("Confirm password does not match.");
    }

    if (errors.isNotEmpty) {
      showToast(msg: errors.join(' '));
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
      return false;
    }

    return true;
  }

  bool isValidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(email);
  }
}
