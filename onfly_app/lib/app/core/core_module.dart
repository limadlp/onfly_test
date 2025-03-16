import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/api/dio_api_client.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<StorageService>(SharedPrefsStorageService.new);
    i.addSingleton<ApiClient>(DioApiClient.new);
  }
}
