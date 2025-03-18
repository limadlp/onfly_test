import 'package:flutter/material.dart';
import 'package:onfly_app/app/core/ui/widgets/indicator.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

final List<Map<String, dynamic>> expensesData = [
  {'category': 'Alimentação', 'color': OnflyColors.primary},
  {'category': 'Transporte', 'color': OnflyColors.secondary},
  {'category': 'Hospedagem', 'color': OnflyColors.success},
  {'category': 'Outros', 'color': OnflyColors.warning},
];

class ChartIndicators extends StatelessWidget {
  const ChartIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          expensesData.map((data) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Indicator(color: data['color'], text: data['category']),
            );
          }).toList(),
    );
  }
}
