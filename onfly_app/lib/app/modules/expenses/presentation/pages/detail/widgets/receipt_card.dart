import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ReceiptCard extends StatefulWidget {
  final Expense expense;

  const ReceiptCard({super.key, required this.expense});

  @override
  State<ReceiptCard> createState() => _ReceiptCardState();
}

class _ReceiptCardState extends State<ReceiptCard> {
  bool _expanded = false;

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
                //TODO: Adicionar download e compartilhamento
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () {},
                    ),
                    IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Container(
                height: _expanded ? null : 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: OnflyColors.gray100,
                ),
                clipBehavior: Clip.hardEdge,
                child:
                    widget.expense.receiptUrl != null &&
                            widget.expense.receiptUrl!.isNotEmpty
                        ? Image.network(
                          widget.expense.receiptUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 64,
                                color: OnflyColors.gray400,
                              ),
                            );
                          },
                        )
                        : const Center(
                          child: Icon(
                            Icons.receipt_long,
                            size: 64,
                            color: OnflyColors.gray400,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
