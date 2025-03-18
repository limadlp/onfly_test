import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/modules/base/presentation/pages/widgets/onfly_app_bar.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 0;

  final List<String> _routes = [
    AppRoutes.expenses,
    AppRoutes.card,
    AppRoutes.trips,
  ];

  @override
  void initState() {
    super.initState();

    Modular.to.navigate(AppRoutes.expenses);

    _updateIndex(Modular.to.path);

    Modular.to.addListener(_listener);
  }

  @override
  void dispose() {
    Modular.to.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    _updateIndex(Modular.to.path);
  }

  void _updateIndex(String path) {
    final index = _routes.indexWhere((route) => path.startsWith(route));
    if (index != -1 && _currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnflyAppBar(),
      body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Modular.to.navigate(_routes[index]);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: 'Despesas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Cartão',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Passagens',
          ),
        ],
      ),
    );
  }
}
