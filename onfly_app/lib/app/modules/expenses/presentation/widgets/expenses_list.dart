import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';

import 'package:onfly_app/app/modules/expenses/presentation/widgets/expense_item.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_total_card.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesList extends StatelessWidget {
  final ExpensesState state;

  const ExpensesList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Descrição',
                          style: TextStyle(
                            fontSize: 12,
                            color: OnflyColors.gray500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Valor',
                          style: TextStyle(
                            fontSize: 12,
                            color: OnflyColors.gray500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (state.filteredExpenses.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: Text('Nenhuma despesa encontrada')),
                    )
                  else
                    ...state.filteredExpenses.map(
                      (expense) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ExpenseItem(expense: expense),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          ExpensesTotalCard(total: state.totalAmount),
        ]),
      ),
    );
  }
}
