import 'package:onfly_api/repositories/auth_repository.dart';

import '../models/user_model.dart';
import '../utils/jwt_service.dart';

class AuthService {
  final AuthRepository _authRepository = AuthRepository();

  /// Handles user registration
  Future<UserModel?> signUp(String name, String email, String password) async {
    final existingUser = await _authRepository.getUserByEmail(email);
    if (existingUser != null) return null;

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );

    await _authRepository.addUser(user);
    return user;
  }

  /// Handles user login and returns a JWT token
  Future<String?> signIn(String email, String password) async {
    final user = await _authRepository.getUserByEmail(email);
    if (user == null || user.password != password) return null;

    return JwtService.generateToken(user.email);
  }
}
