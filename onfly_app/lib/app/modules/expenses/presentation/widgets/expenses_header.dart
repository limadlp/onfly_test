import 'package:flutter/material.dart';
import 'package:onfly_app/app/core/ui/widgets/onfly_filter_chip.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesHeader extends StatelessWidget {
  final ExpensesState state;
  final ValueChanged<String> onSearchQueryChanged;
  final ValueChanged<ExpenseFilter> onFilterSelected;

  const ExpensesHeader({
    super.key,
    required this.state,
    required this.onSearchQueryChanged,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minhas Despesas',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),

        TextField(
          decoration: InputDecoration(
            hintText: 'Buscar despesas',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: OnflyColors.gray200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: OnflyColors.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: OnflyColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            filled: true,
            //fillColor: Colors.white,
          ),
          onChanged: onSearchQueryChanged,
        ),
        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              OnflyFilterChip(
                label: 'Todas',
                isSelected: state.filter == ExpenseFilter.all,
                onSelected: (_) => onFilterSelected(ExpenseFilter.all),
              ),
              const SizedBox(width: 8),
              OnflyFilterChip(
                label: 'Pendentes',
                isSelected: state.filter == ExpenseFilter.pending,
                onSelected: (_) => onFilterSelected(ExpenseFilter.pending),
              ),
              const SizedBox(width: 8),
              OnflyFilterChip(
                label: 'Aprovadas',
                isSelected: state.filter == ExpenseFilter.approved,
                onSelected: (_) => onFilterSelected(ExpenseFilter.approved),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
