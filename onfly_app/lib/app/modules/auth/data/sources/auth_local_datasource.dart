import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storageService;

  AuthLocalDataSourceImpl(this.storageService);

  @override
  Future<void> saveToken(String token) async {
    try {
      await storageService.saveToken(token);
    } catch (e) {
      throw StorageException('Failed to save token');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await storageService.getToken();
    } catch (e) {
      throw StorageException('Failed to retrieve token');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await storageService.clearToken();
    } catch (e) {
      throw StorageException('Failed to clear token');
    }
  }
}
