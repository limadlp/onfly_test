import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/add/add_expense_page.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/widgets/chart/chart_card_container.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/widgets/expenses_header.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/widgets/expenses_list.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await BlocProvider.of<ExpensesCubit>(context).loadExpenses();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpensesHeader(
                          state: state,
                          onSearchQueryChanged: (query) {
                            BlocProvider.of<ExpensesCubit>(
                              context,
                            ).setSearchQuery(query);
                          },
                          onFilterSelected: (filter) {
                            BlocProvider.of<ExpensesCubit>(
                              context,
                            ).setFilter(filter);
                          },
                        ),

                        const SizedBox(height: 16),

                        if (state.status == ExpensesStatus.error)
                          Center(
                            child: Text(
                              'Erro ao carregar despesas: ${state.errorMessage}',
                              style: const TextStyle(color: OnflyColors.alert),
                            ),
                          ),

                        if (state.status != ExpensesStatus.loading &&
                            state.expenses.isNotEmpty)
                          ChartCardContainer(
                            expensesByCategory: state.expensesByCategory,
                          ),
                      ],
                    ),
                  ),
                ),

                if (state.status == ExpensesStatus.loading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.expenses.isNotEmpty)
                  ExpensesList(
                    state: state,
                    cubit: context.read<ExpensesCubit>(),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final expensesCubit = context.read<ExpensesCubit>();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Scaffold(
                        body: AddExpensePage(expensesCubit: expensesCubit),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: OnflyColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
