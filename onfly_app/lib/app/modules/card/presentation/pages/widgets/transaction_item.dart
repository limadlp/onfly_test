import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;

  const TransactionItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: OnflyTypography.bodyLG.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: OnflyTypography.bodyMD.copyWith(
                  color: OnflyColors.gray500,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: OnflyTypography.bodyLG.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
