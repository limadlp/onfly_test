import 'package:onfly_api/core/database_helper.dart';

class UserRepository {
  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final users = await DatabaseHelper.getCollection('users');
    return users.firstWhere((user) => user['email'] == email, orElse: () => {});
  }

  static Future<void> addUser(Map<String, dynamic> user) async {
    await DatabaseHelper.addToCollection('users', user);
  }
}
