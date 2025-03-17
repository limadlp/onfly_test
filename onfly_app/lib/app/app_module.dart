import 'package:flutter_modular/flutter_modular.dart';

import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/core/guards/auth_guard.dart';
import 'package:onfly_app/app/modules/base/base_module.dart';
import 'package:onfly_app/app/modules/auth/auth_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(AppRoutes.auth, module: AuthModule());

    r.module(AppRoutes.home, module: BaseModule(), guards: [AuthGuard()]);

    // Definir a rota inicial para '/auth/'
    //r.redirect(Modular.initialRoute, to: AppRoutes.auth);
  }
}
