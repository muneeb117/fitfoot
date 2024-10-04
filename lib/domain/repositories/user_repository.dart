
import '../entities/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<User?> getUserById(String id);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
