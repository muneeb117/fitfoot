import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  @override
  Future<void> addUser(User user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  @override
  Future<User?> getUserById(String id) async {
    var doc = await firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> updateUser(User user) async {
    await firestore.collection('users').doc(user.id).update(user.toJson());
  }

  @override
  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }
}
