import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/chart/chart_card_container.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_header.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_list.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<ExpensesCubit>().loadExpenses(),
            child: CustomScrollView(
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
                            context.read<ExpensesCubit>().setSearchQuery(query);
                          },
                          onFilterSelected: (filter) {
                            context.read<ExpensesCubit>().setFilter(filter);
                          },
                        ),

                        const SizedBox(height: 16),

                        if (state.status == ExpensesStatus.loading &&
                            state.expenses.isEmpty)
                          const Center(child: CircularProgressIndicator()),
                        if (state.status == ExpensesStatus.error)
                          Center(
                            child: Text(
                              'Erro ao carregar despesas: ${state.errorMessage}',
                              style: const TextStyle(color: OnflyColors.alert),
                            ),
                          ),

                        if (state.status == ExpensesStatus.loaded ||
                            state.expenses.isNotEmpty)
                          ChartCardContainer(
                            expensesByCategory: state.expensesByCategory,
                          ),
                      ],
                    ),
                  ),
                ),

                // Lista de despesas
                if (state.status == ExpensesStatus.loaded ||
                    state.expenses.isNotEmpty)
                  ExpensesList(state: state),

                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //TODO: Ir para a página de criação de despesas
        onPressed: () {},
        backgroundColor: OnflyColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
