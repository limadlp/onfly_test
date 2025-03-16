import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.signup(
      name: name,
      email: email,
      password: password,
    );
  }
}
