import 'package:onfly_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class SigninUseCase {
  final AuthRepository repository;

  SigninUseCase(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.signin(email, password);
  }
}
