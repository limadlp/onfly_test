import 'package:flutter_modular/flutter_modular.dart';

import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_app/app/home_page.dart';
import 'package:onfly_app/app/modules/auth/auth_module.dart';

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
      child: (context) => HomePage(),
      //child: (context) => const BottomBarWidget(),
      guards: [AuthGuard()],
      children: [
        // ModuleRoute(
        //   AppRoutes.expenses,
        //   module: ShoplistModule(),
        //   transition: TransitionType.noTransition,
        // ),
        // ModuleRoute(
        //   AppRoutes.settings,
        //   module: SettingsModule(),
        //   transition: TransitionType.noTransition,
        // ),
        // ModuleRoute(
        //   AppRoutes.profile,
        //   module: ProfileModule(),
        //   transition: TransitionType.noTransition,
        // ),
      ],
    );
    // r.child(
    //   '/list_items/:slug', // 🔥 Definição da rota dinâmica
    //   child: (context) {
    //     final slug = Modular.args.params['slug']!; // 🔥 Obtendo o slug
    //     final list =
    //         Modular.args.data
    //             as Map<String, dynamic>?; // 🔥 Pegando os dados extras

    //     return ListItemsPage(
    //       slug: slug,
    //       list: list ?? {}, // Se `list` for nulo, passa um mapa vazio
    //     );
    //   },
    //   customTransition: CustomTransition(
    //     transitionBuilder: (context, animation, secondaryAnimation, child) {
    //       return child; // 🔥 Sem animação
    //     },
    //   ),
    // );

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
