import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/widgets/chart/chart_indicators.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/widgets/chart/expenses_chart.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ChartCardContainer extends StatelessWidget {
  final Map<String, double> expensesByCategory;
  const ChartCardContainer({super.key, required this.expensesByCategory});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300, // Define uma altura fixa para evitar redimensionamento
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(OnflySpacings.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Despesas por Categoria', style: OnflyTypography.titleMD),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ExpensesChart(
                        expensesByCategory: expensesByCategory,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(flex: 2, child: ChartIndicators()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
