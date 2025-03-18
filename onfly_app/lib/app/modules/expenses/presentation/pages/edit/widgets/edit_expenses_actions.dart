import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class EditExpenseActions extends StatelessWidget {
  final bool isSaving;
  final bool isDeleting;
  final VoidCallback onSubmit;
  final VoidCallback onDelete;

  const EditExpenseActions({
    super.key,
    required this.isSaving,
    required this.isDeleting,
    required this.onSubmit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (isSaving || isDeleting) ? null : onSubmit,
            child:
                isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Salvar'),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: OutlinedButton(
            onPressed: (isSaving || isDeleting) ? null : onDelete,
            style: OutlinedButton.styleFrom(foregroundColor: OnflyColors.alert),
            child:
                isDeleting
                    ? const CircularProgressIndicator()
                    : const Text('Excluir'),
          ),
        ),
      ],
    );
  }
}
