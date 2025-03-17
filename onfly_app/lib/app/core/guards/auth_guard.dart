// TODO: Improve this guard
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.auth);
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final storage = Modular.get<StorageService>();
    final token = await storage.getToken();
    if (token == null) {
      return false;
    }
    return true;
  }
}
