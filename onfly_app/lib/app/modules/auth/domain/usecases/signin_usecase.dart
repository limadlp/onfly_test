import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class SigninUsecase {
  final AuthRepository repository;

  SigninUsecase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signin(email: email, password: password);
  }
}
