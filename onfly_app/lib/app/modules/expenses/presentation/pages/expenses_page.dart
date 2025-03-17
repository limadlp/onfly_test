import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense_status.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_card_container.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpensesCubit>().fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(OnflySpacings.pageMargin),
          child: const ExpensesCardContainer(),
        ),
      ),
    );
  }
}

//TODO: remove this
final expenses = [
  Expense(
    id: '1',
    userId: 'user123',
    date: '15/03/2023',
    amount: 120.304,
    category: 'Transporte',
    description: 'Taxi aeroporto',
    status: ExpenseStatus.pending.label,
    notes: '',
    location: 'São Paulo',
    paymentMethod: 'Cartão de crédito',
    approvedBy: '',
    approvedAt: '',
    isSynced: true,
    hasReceipt: false,
    receiptUrl: null,
  ),
  Expense(
    id: '2',
    userId: 'user123',
    date: '16/03/2023',
    amount: 350.0,
    category: 'Hospedagem',
    description: 'Hotel Ibis',
    status: ExpenseStatus.rejected.label,
    notes: '',
    location: 'São Paulo',
    paymentMethod: 'Cartão de crédito',
    approvedBy: '',
    approvedAt: '',
    isSynced: true,
    hasReceipt: true,
    receiptUrl: 'https://example.com/receipt2.pdf',
  ),
  Expense(
    id: '3',
    userId: 'user123',
    date: '17/03/2023',
    amount: 75.0,
    category: 'Outros',
    description: 'Material escritório 2',
    status: ExpenseStatus.approved.label,
    notes: '',
    location: 'São Paulo',
    paymentMethod: 'Cartão de crédito',
    approvedBy: 'approver123',
    approvedAt: '2025-03-10T12:00:00Z',
    isSynced: true,
    hasReceipt: true,
    receiptUrl: 'https://example.com/receipt3.pdf',
  ),
];
