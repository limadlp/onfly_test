import 'package:flutter/material.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';

class ExpensesTotalCard extends StatelessWidget {
  final double total;

  const ExpensesTotalCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: Theme.of(context).textTheme.titleMedium),
            Text(total.toBRL(), style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
