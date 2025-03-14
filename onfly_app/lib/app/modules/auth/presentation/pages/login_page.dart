import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Text('Hello World'),
            OnflyTextField(label: 'label', controller: controller),
            OnflyButton(label: "Clique Aqui", onPressed: () => print('Clicou')),
          ],
        ),
      ),
    );
  }
}
