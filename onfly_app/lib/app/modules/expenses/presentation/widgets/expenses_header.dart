import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesHeader extends StatelessWidget {
  const ExpensesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Descrição',
                style: OnflyTypography.bodyLG.copyWith(
                  color: OnflyColors.gray500,
                ),
              ),
              const Icon(Icons.swap_vert, size: 14, color: Colors.grey),
            ],
          ),
          Row(
            children: [
              Text(
                'Valor',
                style: OnflyTypography.bodyLG.copyWith(
                  color: OnflyColors.gray500,
                ),
              ),
              const Icon(Icons.swap_vert, size: 14, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
