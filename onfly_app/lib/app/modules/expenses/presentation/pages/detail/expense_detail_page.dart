import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/detail/widgets/expense_card.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/detail/widgets/receipt_card.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/edit/edit_expenses_page.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpenseDetailPage extends StatefulWidget {
  final String expenseId;

  const ExpenseDetailPage({super.key, required this.expenseId});

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  late Future<Expense> _expenseFuture;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadExpense();
  }

  void _loadExpense() {
    _expenseFuture = context.read<ExpensesCubit>().getExpense(widget.expenseId);
  }

  Future<void> _deleteExpense() async {
    if (_isDeleting) return;

    setState(() => _isDeleting = true);

    final expensesCubit = context.read<ExpensesCubit>();

    try {
      await expensesCubit.deleteExpense(widget.expenseId);

      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir despesa: $e'),
            backgroundColor: OnflyColors.alert,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Despesa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Expense>(
        future: _expenseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar despesa: ${snapshot.error}',
                style: OnflyTypography.label.copyWith(color: OnflyColors.alert),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Despesa não encontrada'));
          }

          final expense = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpenseCard(expense: expense),
                const SizedBox(height: 16),
                if (expense.hasReceipt) ReceiptCard(expense: expense),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            _isDeleting
                                ? null
                                : () {
                                  final expensesCubit =
                                      context.read<ExpensesCubit>();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder:
                                        (context) => BlocProvider.value(
                                          value: expensesCubit,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: EditExpensePage(
                                              expenseId: expense.id,
                                              expensesCubit: expensesCubit,
                                            ),
                                          ),
                                        ),
                                  );
                                },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: OnflyColors.primary,
                          side: const BorderSide(color: OnflyColors.primary),
                        ),
                        child: const Text('Editar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isDeleting ? null : _deleteExpense,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OnflyColors.alert,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            _isDeleting
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : const Text('Excluir'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
