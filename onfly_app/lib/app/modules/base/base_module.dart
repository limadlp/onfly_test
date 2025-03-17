import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/core/guards/auth_guard.dart';
import 'package:onfly_app/app/modules/base/presentation/pages/base_page.dart';
import 'package:onfly_app/app/modules/card/card_module.dart';
import 'package:onfly_app/app/modules/expenses/expenses_module.dart';
import 'package:onfly_app/app/modules/trips/trips_module.dart';

class BaseModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const BasePage(),
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
  }
}
