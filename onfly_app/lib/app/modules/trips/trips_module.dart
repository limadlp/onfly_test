import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/modules/trips/presentation/pages/trips_page.dart';

class TripsModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const TripsPage());
  }
}
