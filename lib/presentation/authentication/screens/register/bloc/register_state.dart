import 'dart:io';

class RegisterState {
  String email;
  String name;
  String password;
  String rePassword;
  File? imageUrl; // New field for image URL
  final bool isLoading;

  RegisterState({
    this.email = "",
    this.name = "",
    this.password = "",
    this.rePassword = "",
    this.imageUrl, // Initialize with an empty string
    this.isLoading = false
  });

  RegisterState copyWith({
    String? email,
    String? name,
    String? password,
    String? rePassword,
    File? imageUrl, // Add imageUrl parameter
    bool? isLoading,
  }) {
    return RegisterState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,

      imageUrl: imageUrl ?? this.imageUrl, // Assign imageUrl
      isLoading: isLoading ?? this.isLoading,
    );
  }

}
