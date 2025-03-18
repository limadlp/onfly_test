import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/cubit/theme_cubit.dart';
import 'package:onfly_app/app/core/cubit/theme_state.dart';
import 'package:onfly_app/app/core/extensions/custom_scroll_behavior.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final lightTheme = OnflyTheme.light;
          final darkTheme = OnflyTheme.dark;

          return MaterialApp.router(
            routerConfig: Modular.routerConfig,
            title: 'Onfly',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                state.themeMode == AppThemeMode.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
