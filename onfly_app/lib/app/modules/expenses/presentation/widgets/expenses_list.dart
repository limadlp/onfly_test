import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/utils/date_utils.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/onfly_expense_card.dart';
import 'package:onfly_app/app/core/ui/widgets/skeleton.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return Column(
            children: List.generate(
              3,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Skeleton(height: 80, width: double.infinity),
              ),
            ),
          );
        } else if (state is ExpensesLoaded) {
          return Column(
            children:
                state.expenses
                    .map(
                      (expense) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: OnflyExpenseCard(
                          description: expense.description,
                          amount: expense.amount,
                          date: FormatUtils.formatDate(expense.date),
                          category: expense.category,
                          status: expense.status,
                          hasReceipt: expense.hasReceipt,
                          onTap: () {},
                        ),
                      ),
                    )
                    .toList(),
          );
        } else if (state is ExpensesError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
