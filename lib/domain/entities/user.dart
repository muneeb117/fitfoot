// lib/domain/entities/user.dart

class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  User({required this.id, required this.name, required this.email, required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  static User fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      imageUrl: data['imageUrl'],
    );
  }
}
