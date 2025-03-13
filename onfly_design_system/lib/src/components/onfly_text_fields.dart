import 'package:flutter/material.dart';
import 'package:onfly_design_system/src/tokens/onfly_colors.dart';
import 'package:onfly_design_system/src/tokens/onfly_typography.dart';

class OnflyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const OnflyTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: OnflyTypography.bodyMD,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: OnflyColors.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
