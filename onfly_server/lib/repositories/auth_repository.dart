import '../utils/database_helper.dart';
import '../models/user_model.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Retrieves a user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final users = await _dbHelper.getCollection('users');
    final userData = users.firstWhere(
      (user) => user['email'] == email,
      orElse: () => <String, dynamic>{},
    );

    if (userData.isEmpty) return null;
    return UserModel.fromJson(userData);
  }

  /// Saves a new user
  Future<void> addUser(UserModel user) async {
    await _dbHelper.addToCollection('users', user.toJson());
  }
}
