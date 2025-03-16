import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_local_datasource.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';
import 'package:onfly_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failure, String>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signin(
        email: email,
        password: password,
      );

      return result.fold((failure) => Left(failure), (token) async {
        await authLocalDataSource.saveToken(token);
        return Right(token);
      });
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );

      return result.fold((failure) => Left(failure), (userModel) async {
        await authLocalDataSource.saveToken(userModel.token ?? '');
        return Right(userModel);
      });
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    try {
      await authLocalDataSource.clearToken();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to sign out: ${e.toString()}'));
    }
  }
}
