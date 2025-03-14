import 'package:flutter/material.dart';
import 'package:onfly_app/home_page.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: OnflyTheme.light,
      home: const HomePage(),
    );
  }
}
