import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';
import 'package:onfly_app/app/core/utils/date_utils.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpenseDetailPage extends StatefulWidget {
  final String expenseId;

  const ExpenseDetailPage({super.key, required this.expenseId});

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  bool _receiptExpanded = false;
  late Future<Expense> _expenseFuture;

  @override
  void initState() {
    super.initState();
    _loadExpense();
  }

  void _loadExpense() {
    _expenseFuture = context.read<ExpensesCubit>().getExpense(widget.expenseId);
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
                _buildExpenseCard(expense),
                const SizedBox(height: 16),
                if (expense.hasReceipt) _buildReceiptCard(expense),
                const SizedBox(height: 16),
                _buildActionButtons(expense),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpenseCard(Expense expense) {
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
                _buildStatusBadge(expense.status),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              expense.amount.toBRL(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            _buildInfoItem(
              Icons.calendar_today,
              'Data',
              FormatUtils.formatDate(expense.date),
            ),
            const SizedBox(height: 16),
            _buildInfoItem(Icons.category, 'Categoria', expense.category),
            if (expense.location != null) ...[
              const SizedBox(height: 16),
              _buildInfoItem(Icons.location_on, 'Local', expense.location!),
            ],
            if (expense.paymentMethod != null) ...[
              const SizedBox(height: 16),
              _buildInfoItem(
                Icons.credit_card,
                'Forma de pagamento',
                expense.paymentMethod!,
              ),
            ],
            if (expense.notes != null) ...[
              const SizedBox(height: 16),
              _buildInfoItem(Icons.description, 'Observações', expense.notes!),
            ],
            if (expense.status == 'approved' && expense.approvedBy != null) ...[
              const SizedBox(height: 16),
              _buildInfoItem(
                Icons.person,
                'Aprovado por',
                '${expense.approvedBy!}${expense.approvedAt != null ? ' em ${DateTime.parse(expense.approvedAt!).day}/${DateTime.parse(expense.approvedAt!).month}/${DateTime.parse(expense.approvedAt!).year}' : ''}',
              ),
            ],
            if (expense.status == 'rejected' &&
                expense.rejectionReason != null) ...[
              const SizedBox(height: 16),
              _buildInfoItem(
                Icons.error_outline,
                'Motivo da reprovação',
                expense.rejectionReason!,
                iconColor: OnflyColors.alert,
                valueColor: OnflyColors.alert,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard(Expense expense) {
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
                Row(
                  children: [
                    const Icon(Icons.receipt, color: OnflyColors.secondary),
                    const SizedBox(width: 8),
                    Text(
                      'Comprovante',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  //TODO: Implementar download e compartilhamento do comprovante
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        // Download receipt
                      },
                      iconSize: 20,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Share receipt
                      },
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  _receiptExpanded = !_receiptExpanded;
                });
              },
              child: Stack(
                children: [
                  Container(
                    height: _receiptExpanded ? null : 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: OnflyColors.gray100,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child:
                        expense.receiptUrl != null
                            ? Image.network(
                              expense.receiptUrl!,
                              fit: BoxFit.contain,
                            )
                            : const Center(
                              child: Icon(
                                Icons.receipt_long,
                                size: 64,
                                color: OnflyColors.gray400,
                              ),
                            ),
                  ),
                  if (!_receiptExpanded)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white,
                            ],
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Ver comprovante completo',
                          style: TextStyle(
                            color: OnflyColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(Expense expense) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              //TODO: Navigate to edit expense Page
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: OnflyColors.primary,
              side: const BorderSide(color: OnflyColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Editar'),
          ),
        ),
        const SizedBox(width: 16),
        if (expense.status == 'pending')
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _showDeleteConfirmation(expense);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: OnflyColors.alert,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Excluir'),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value, {
    Color? iconColor,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor ?? OnflyColors.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: OnflyColors.gray500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
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
        backgroundColor = Colors.grey;
        textColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
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

  void _showDeleteConfirmation(Expense expense) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir despesa'),
            content: const Text('Tem certeza que deseja excluir esta despesa?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<ExpensesCubit>().deleteExpense(expense.id).then((
                    _,
                  ) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  });
                },
                style: TextButton.styleFrom(foregroundColor: OnflyColors.alert),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }
}
