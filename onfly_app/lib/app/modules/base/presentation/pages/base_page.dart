import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

//TODO: Criar um base módulo?
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
      appBar: AppBar(
        title: Text('Onfly', style: OnflyTypography.titleXL),
        actions: [
          // TODO: Implementar busca de nome de usuário
          PopupMenuButton(
            padding: const EdgeInsets.symmetric(
              horizontal: OnflySpacings.buttonPaddingHorizontal,
            ),
            icon: const Icon(Icons.account_circle),
            itemBuilder:
                (context) => [
                  // PopupMenuItem(
                  //   enabled: false,
                  //   child: Text(
                  //     'John Doe',
                  //     style: OnflyTypography.titleSM,
                  //   ),
                  // ),
                  const PopupMenuItem(
                    value: 'signout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
            onSelected: (value) {
              if (value == 'signout') {
                Modular.get<StorageService>().clearToken();
                Modular.to.navigate(AppRoutes.auth);
              }
            },
          ),
        ],
      ),
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
