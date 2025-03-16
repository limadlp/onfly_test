import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyTextInput extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isRequired;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffix;
  final Function(String)? onChanged;

  const OnflyTextInput({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.isRequired = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffix,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: OnflyTypography.label),
            if (isRequired)
              Text(
                '*',
                style: OnflyTypography.label.copyWith(color: OnflyColors.alert),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffix: suffix,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          style: OnflyTypography.bodyLG,
        ),
      ],
    );
  }
}
