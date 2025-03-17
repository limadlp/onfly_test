import 'package:flutter/material.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyExpenseCard extends StatelessWidget {
  final String description;
  final double amount;
  final String date;
  final String category;
  final String status;
  final bool hasReceipt;
  final VoidCallback onTap;

  const OnflyExpenseCard({
    super.key,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.status,
    required this.hasReceipt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: OnflyBorders.largeRadius,
      child: Container(
        padding: const EdgeInsets.all(OnflySpacings.md),
        decoration: BoxDecoration(
          color: OnflyColors.white,
          borderRadius: OnflyBorders.largeRadius,
          border: Border.all(color: OnflyColors.gray200),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.receipt_outlined,
                color: hasReceipt ? OnflyColors.secondary : OnflyColors.gray500,
                size: 20,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: OnflyTypography.bodyLG.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OnflyStatusBadge(status: status),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: OnflyTypography.bodySM.copyWith(
                            color: OnflyColors.gray500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category,
                          style: OnflyTypography.bodySM.copyWith(
                            color: OnflyColors.gray500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    amount.toBRL(),
                    style: OnflyTypography.bodyLG.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: OnflyColors.gray400,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
