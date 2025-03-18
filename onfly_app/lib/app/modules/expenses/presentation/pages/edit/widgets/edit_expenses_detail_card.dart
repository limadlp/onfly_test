import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class EditExpenseDetailsCard extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final TextEditingController notesController;

  final DateTime selectedDate;
  final VoidCallback onSelectDate;

  final String selectedCategory;
  final ValueChanged<String> onCategoryChange;

  final File? receiptImage;
  final VoidCallback onPickImage;

  final List<String> categories;

  const EditExpenseDetailsCard({
    super.key,
    required this.descriptionController,
    required this.amountController,
    required this.notesController,
    required this.selectedDate,
    required this.onSelectDate,
    required this.selectedCategory,
    required this.onCategoryChange,
    required this.receiptImage,
    required this.onPickImage,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição*'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: amountController,
                    decoration: const InputDecoration(labelText: 'Valor*'),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: onSelectDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Data*'),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(labelText: 'Categoria*'),
              items:
                  categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
              onChanged: (value) {
                if (value != null) onCategoryChange(value);
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Observações'),
              maxLines: 3,
            ),

            const SizedBox(height: 16),

            _buildReceiptPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptPreview() {
    if (receiptImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(receiptImage!, fit: BoxFit.cover),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: onPickImage,
              /*  */
              child: const CircleAvatar(
                backgroundColor: OnflyColors.alert,
                radius: 16,
                child: Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: onPickImage,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: OnflyColors.gray200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Icon(Icons.upload_file, size: 40, color: OnflyColors.secondary),
            SizedBox(height: 8),
            Text(
              'Clique para enviar comprovante',
              style: TextStyle(color: OnflyColors.gray500),
            ),
          ],
        ),
      ),
    );
  }
}
