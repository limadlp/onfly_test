import 'package:flutter/material.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/detail/widgets/info_item.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/detail/widgets/status_badge.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expense.description,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                StatusBadge(status: expense.status),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              expense.amount.toBRL(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            InfoItem(
              icon: Icons.calendar_today,
              label: 'Data',
              value: expense.date,
            ),
            const SizedBox(height: 16),
            InfoItem(
              icon: Icons.category,
              label: 'Categoria',
              value: expense.category,
            ),
            if (expense.location != null)
              InfoItem(
                icon: Icons.location_on,
                label: 'Local',
                value: expense.location!,
              ),
          ],
        ),
      ),
    );
  }
}
