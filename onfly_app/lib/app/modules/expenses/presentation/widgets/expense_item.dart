import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';
import 'package:onfly_app/app/core/utils/date_utils.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/detail/expense_detail_page.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final ExpensesCubit cubit;

  const ExpenseItem({super.key, required this.expense, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder:
              (context) => BlocProvider.value(
                value: cubit, // Passa o Cubit existente
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Scaffold(
                          body: ExpenseDetailPage(expenseId: expense.id),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: OnflyColors.gray200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.receipt,
                size: 20,
                color:
                    expense.hasReceipt
                        ? OnflyColors.secondary
                        : OnflyColors.gray300,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.description,
                    style: OnflyTypography.bodyLG,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildStatusBadge(expense.status),
                      Text(
                        FormatUtils.formatDate(expense.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: OnflyColors.gray500,
                        ),
                      ),
                      Text(
                        expense.category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: OnflyColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  expense.amount.toBRL(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: OnflyColors.gray400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'pending':
        backgroundColor = OnflyColors.warning;
        textColor = Colors.black;
        break;
      case 'approved':
        backgroundColor = OnflyColors.success;
        textColor = Colors.white;
        break;
      case 'rejected':
        backgroundColor = OnflyColors.alert;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = OnflyColors.gray300;
        textColor = Colors.black;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pendente';
      case 'approved':
        return 'Aprovada';
      case 'rejected':
        return 'Reprovada';
      default:
        return 'Desconhecido';
    }
  }
}
