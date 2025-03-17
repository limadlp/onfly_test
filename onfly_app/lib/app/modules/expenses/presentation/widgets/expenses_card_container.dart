import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_header.dart';
import 'package:onfly_app/app/modules/expenses/presentation/widgets/expenses_list.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class ExpensesCardContainer extends StatelessWidget {
  const ExpensesCardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(OnflySpacings.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ExpensesHeader(), ExpensesList()],
        ),
      ),
    );
  }
}
