import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/expenses_page.dart';

class ExpensesModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const ExpensesPage());
  }
}
