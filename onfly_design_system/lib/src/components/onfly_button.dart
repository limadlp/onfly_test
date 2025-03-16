import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

enum ButtonType { primary, success, alert, disabled }

class OnflyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;

  const OnflyButton({
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
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
      onPressed: isLoading || type == ButtonType.disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor..withValues(alpha: 0.6),
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: OnflyBorders.mediumRadius),
        padding: EdgeInsets.symmetric(
          horizontal: OnflySpacings.buttonPaddingHorizontal,
          vertical: OnflySpacings.buttonPaddingVertical,
        ),
        foregroundColor: Colors.white,
      ),
      child:
          isLoading
              ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(OnflyColors.white),
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: OnflyColors.white),
                    SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: OnflyTypography.bodyLG.copyWith(
                      fontWeight: FontWeight.w500,
                      color: OnflyColors.white,
                    ),
                  ),
                ],
              ),
    );
  }
}
