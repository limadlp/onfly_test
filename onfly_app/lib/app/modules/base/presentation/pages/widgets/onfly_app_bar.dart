import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/constants/app_routes.dart';
import 'package:onfly_app/app/core/cubit/theme_cubit.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnflyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Onfly', style: OnflyTypography.titleXL),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_4),
          onPressed: () {
            BlocProvider.of<ThemeCubit>(context, listen: false).toggleTheme();
          },
        ),
        PopupMenuButton(
          padding: const EdgeInsets.symmetric(
            horizontal: OnflySpacings.buttonPaddingHorizontal,
          ),
          icon: const Icon(Icons.account_circle),
          itemBuilder:
              (context) => [
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
