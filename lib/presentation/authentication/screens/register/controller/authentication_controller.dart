import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/global/widgets/toast_info.dart';
import '../../../../../data/repositories/firebase_user_repository.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/repositories/user_repository.dart';
import '../../../../../main/navigation/routes/name.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';

class AuthenticationController {
  UserRepository userRepository = FirebaseUserRepository();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadAndUpdateProfileImage(
      File imageFile, String userId) async {
    String imageUrl = await _uploadImageToStorage(imageFile, userId);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({'image': imageUrl});
  }

  Future<File> chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedImageFile!.path);
  }

  Future<File> captureImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return File(pickedImageFile!.path);
  }

  Future<void> signUp(
      String email, String password, String name, BuildContext context) async {
    try {
      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      userCredential.user?.emailVerified;
      User newUser = User(
          id: userCredential.user!.uid, name: name, email: email, imageUrl: '');
      await userRepository.addUser(newUser);
      showToast(
          msg: "Verification email has been sent. Please check your email.");
      context.read<RegisterBloc>().add(RegisterLoadingEvent(false));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.login, (route) => false);
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      switch (e.code) {
        case 'weak-password':
          errorMessage = "The password provided is too weak.";
          context
              .read<RegisterBloc>()
              .add(RegisterLoadingEvent(false)); // Stop loading

          break;
        case 'email-already-in-use':
          errorMessage = "An account already exists for that email.";
          context
              .read<RegisterBloc>()
              .add(RegisterLoadingEvent(false)); // Stop loading

          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          context
              .read<RegisterBloc>()
              .add(RegisterLoadingEvent(false)); // Stop loading

          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
      showToast(
        msg: errorMessage,
      );
    } catch (e) {
      showToast(
        msg: "Error during registration: ${e.toString()}",
      );
    }
  }

  Future<String> _uploadImageToStorage(File? image, String userId) async {
    if (image == null) return '';
    Reference ref = storage.ref().child("Profile Images/$userId");
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> signOut() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
  }

  void resetPassword(String email, BuildContext context) async {
    try {
      await firebase_auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      showToast(
        msg: "Password reset email sent.",
      );
    } catch (e) {
      showToast(
        msg: "Error sending reset email: ${e.toString()}",
      );
    }
  }
}
