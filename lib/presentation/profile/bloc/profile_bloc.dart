import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/local/user_database.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseHelper _databaseHelper;

  ProfileBloc({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper,
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileImage>(_onUpdateProfileImage);
    on<UpdateProfileName>(_onUpdateProfileName);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileData = await _databaseHelper.getUserProfile(user.uid);

        if (profileData != null) {
          emit(ProfileLoaded(
            name: profileData['user_name'] ?? 'Enter your name',
            imageUrl: profileData['image_path'] ?? '',
          ));
        } else {
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (doc.exists) {
            final imageUrl = doc.data()?['imageUrl'] ?? '';
            final name = doc.data()?['name'] ?? '';

            await _databaseHelper.insertUserProfile(
              user.uid,
              imageUrl,
              name.isNotEmpty ? name : "Enter your name",
            );

            emit(ProfileLoaded(
              name: name.isNotEmpty ? name : 'Enter your name',
              imageUrl: imageUrl,
            ));
          } else {
            emit(const ProfileError(message: "User profile not found"));
          }
        }
      } else {
        emit(const ProfileError(message: "No user logged in"));
      }
    } catch (e) {
      emit(ProfileError(message: "Failed to load profile: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateProfileImage(UpdateProfileImage event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'imageUrl': event.imagePath});

          await _databaseHelper.updateUserProfile(
            user.uid,
            event.imagePath,
            currentState.name,
          );

          emit(ProfileLoaded(
            name: currentState.name,
            imageUrl: event.imagePath,
          ));
        }
      } catch (e) {
        emit(ProfileError(message: "Failed to update image: ${e.toString()}"));
      }
    }
  }

  Future<void> _onUpdateProfileName(UpdateProfileName event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'name': event.name});

          await _databaseHelper.updateUserProfile(
            user.uid,
            currentState.imageUrl,
            event.name,
          );

          emit(ProfileLoaded(
            name: event.name,
            imageUrl: currentState.imageUrl,
          ));
        }
      } catch (e) {
        emit(ProfileError(message: "Failed to update name: ${e.toString()}"));
      }
    }
  }
}
