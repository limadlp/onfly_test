import 'package:flutter/material.dart';
import 'package:onfly_design_system/src/tokens/onfly_colors.dart';
import 'package:onfly_design_system/src/tokens/onfly_typography.dart';

enum ButtonType { primary, success, alert, disabled }

class OnflyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;

  const OnflyButton({
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (type) {
      case ButtonType.success:
        backgroundColor = OnflyColors.success;
        break;
      case ButtonType.alert:
        backgroundColor = OnflyColors.alert;
        break;
      case ButtonType.disabled:
        backgroundColor = OnflyColors.background;
        break;
      default:
        backgroundColor = OnflyColors.primary;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        textStyle: OnflyTypography.bodyLG,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: type == ButtonType.disabled ? null : onPressed,
      child: Text(label),
    );
  }
}
