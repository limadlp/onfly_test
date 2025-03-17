import 'package:flutter_modular/flutter_modular.dart';

import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_app/app/core/ui/widgets/bottom_bar_widget.dart';
import 'package:onfly_app/app/modules/auth/auth_module.dart';
import 'package:onfly_app/app/modules/card/card_module.dart';
import 'package:onfly_app/app/modules/expenses/expenses_module.dart';
import 'package:onfly_app/app/modules/trips/trips_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(AppRoutes.auth, module: AuthModule());
    r.child(
      AppRoutes.home,
      child: (context) => const BottomBarWidget(),
      //child: (context) => const BottomBarWidget(),
      guards: [AuthGuard()],
      children: [
        ModuleRoute(
          AppRoutes.expenses,
          module: ExpensesModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          AppRoutes.card,
          module: CardModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          AppRoutes.trips,
          module: TripsModule(),
          transition: TransitionType.noTransition,
        ),
      ],
    );

    // Definir a rota inicial para '/auth/'
    //r.redirect(Modular.initialRoute, to: AppRoutes.auth);
  }
}

// TODO: Improve this guard
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
