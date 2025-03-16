import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, String>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, String>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrl.signin,
        data: {'email': email, 'password': password},
      );

      return Right(response['token']);
    } on ApiClientException catch (e) {
      if (e.statusCode == 401) {
        return Left(InvalidCredentialsFailure());
      } else if (e.statusCode == 400 || e.statusCode == 409) {
        return Left(ServerFailure(e.message));
      }
      return Left(
        ServerFailure('HTTP Error ${e.statusCode ?? "unknown"}: ${e.message}'),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrl.signup,
        data: {'name': name, 'email': email, 'password': password},
      );

      return Right(UserModel.fromJson(response));
    } on ApiClientException catch (e) {
      if (e.statusCode == 401) {
        return Left(InvalidCredentialsFailure());
      } else if (e.statusCode == 400 || e.statusCode == 409) {
        return Left(ServerFailure(e.message));
      }
      return Left(
        ServerFailure('HTTP Error ${e.statusCode ?? "unknown"}: ${e.message}'),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
