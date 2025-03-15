import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';
import 'package:onfly_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final StorageService storage;

  AuthRepositoryImpl(this.remoteDataSource, this.storage);

  @override
  Future<void> signin(String email, String password) async {
    final user = await remoteDataSource.signin(email, password);
    await storage.saveToken(user.token);
  }

  @override
  Future<void> signout() async {
    await storage.clearToken();
  }
}
