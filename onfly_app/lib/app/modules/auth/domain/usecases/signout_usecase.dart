import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class SignoutUsecase {
  final AuthRepository repository;

  SignoutUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signout();
  }
}
