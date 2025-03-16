import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyCurrencyInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final String? errorText;
  final Function(double)? onChanged;

  const OnflyCurrencyInput({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.errorText,
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
            hintText: 'R\$ 0,00',
            errorText: errorText,
            prefixIcon: Icon(Icons.attach_money),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
          onChanged: (value) {
            if (onChanged != null) {
              // Convert formatted string to double
              final numericValue =
                  double.tryParse(
                    value
                        .replaceAll('R\$ ', '')
                        .replaceAll('.', '')
                        .replaceAll(',', '.'),
                  ) ??
                  0.0;
              onChanged!(numericValue);
            }
          },
          style: OnflyTypography.bodyLG,
        ),
      ],
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Only keep digits
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Convert to double (in cents)
    double value = int.parse(digitsOnly) / 100;

    // Format as currency
    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    );

    String formatted = formatter.format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
