import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signout();
}
