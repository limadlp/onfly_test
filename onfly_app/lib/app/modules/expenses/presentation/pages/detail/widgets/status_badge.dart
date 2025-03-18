import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor(status),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Color _getColor(String status) {
    switch (status) {
      case 'pending':
        return OnflyColors.warning;
      case 'approved':
        return OnflyColors.success;
      case 'rejected':
        return OnflyColors.alert;
      default:
        return Colors.grey;
    }
  }
}
