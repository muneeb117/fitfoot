// profile_event.dart

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileImage extends ProfileEvent {
  final String imagePath;

  const UpdateProfileImage({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class UpdateProfileName extends ProfileEvent {
  final String name;

  const UpdateProfileName({required this.name});

  @override
  List<Object> get props => [name];
}
