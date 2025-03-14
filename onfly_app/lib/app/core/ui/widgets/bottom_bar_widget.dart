import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/app_routes.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
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
      body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Modular.to.navigate(_routes[index]);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Shoplist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
