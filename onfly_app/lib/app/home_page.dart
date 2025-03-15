import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Modular.get<StorageService>().clearToken();
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
