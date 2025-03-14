import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/ui/widgets/bottom_bar_widget.dart';
import 'package:onfly_app/app/modules/auth/auth_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    //i.addSingleton<ThemeController>(ThemeController.new);
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule());

    r.child(
      '/home/',
      child: (context) => const BottomBarWidget(),
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
  }
}
