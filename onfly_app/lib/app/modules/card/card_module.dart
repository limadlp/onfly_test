import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/modules/card/presentation/pages/card_page.dart';

class CardModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const CardPage());
  }
}
