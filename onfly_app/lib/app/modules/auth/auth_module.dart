import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/modules/auth/presentation/pages/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
