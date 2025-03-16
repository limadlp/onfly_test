import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyStatusBadge extends StatelessWidget {
  final String status;

  const OnflyStatusBadge({super.key, required this.status});

  Color get backgroundColor {
    switch (status) {
      case 'pending':
        return OnflyColors.warning;
      case 'approved':
        return OnflyColors.success;
      case 'rejected':
        return OnflyColors.alert;
      default:
        return OnflyColors.gray500;
    }
  }

  Color get textColor {
    if (status == 'pending') {
      return OnflyColors.black;
    }
    return OnflyColors.white;
  }

  String get statusText {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: OnflySpacings.xs,
        vertical: OnflySpacings.xxs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: OnflyBorders.smallRadius,
      ),
      child: Text(
        statusText,
        style: OnflyTypography.bodySM.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
