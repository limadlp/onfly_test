import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflySecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const OnflySecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: OnflyColors.primary),
        minimumSize: Size(double.infinity, 48),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 18), SizedBox(width: 8)],
          Text(text),
        ],
      ),
    );
  }
}
