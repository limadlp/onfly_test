import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/edit/widgets/edit_expenses_actions.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/edit/widgets/edit_expenses_detail_card.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class EditExpensePage extends StatefulWidget {
  final String expenseId;
  final ExpensesCubit expensesCubit;

  const EditExpensePage({
    super.key,
    required this.expenseId,
    required this.expensesCubit,
  });

  @override
  State<EditExpensePage> createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();

  late final TextEditingController _amountController;

  late Expense _originalExpense;
  late Future<Expense> _expenseFuture;

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Alimentação';
  File? _receiptImage;

  bool _isSaving = false;
  bool _isDeleting = false;

  final List<String> _categories = [
    'Alimentação',
    'Transporte',
    'Hospedagem',
    'Outros',
  ];

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();

    _expenseFuture = _loadExpense();
  }

  Future<Expense> _loadExpense() async {
    final expense = await widget.expensesCubit.getExpense(widget.expenseId);
    _originalExpense = expense;

    _descriptionController.text = expense.description;
    _selectedDate = DateTime.parse(expense.date);
    _selectedCategory = expense.category;
    _notesController.text = expense.notes ?? '';

    final amountString = expense.amount.toStringAsFixed(2);

    final brFormat = amountString.replaceAll('.', ',');

    _amountController.text = brFormat;
    return expense;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _receiptImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: OnflyColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
      _isDeleting = false;
    });

    try {
      String numericText = _amountController.text.trim();

      if (numericText.toLowerCase().startsWith('r\$')) {
        numericText = numericText.substring(2).trim();
      }

      if (numericText.startsWith(' ')) {
        numericText = numericText.substring(1).trim();
      }

      numericText = numericText.replaceAll('.', '').replaceAll(',', '.');

      final amountValue = double.parse(numericText);

      final updatedExpense = _originalExpense.copyWith(
        description:
            _descriptionController.text != _originalExpense.description
                ? _descriptionController.text
                : null,
        amount: amountValue != _originalExpense.amount ? amountValue : null,
        date:
            _selectedDate.toIso8601String() != _originalExpense.date
                ? _selectedDate.toIso8601String()
                : null,
        category:
            _selectedCategory != _originalExpense.category
                ? _selectedCategory
                : null,
        notes:
            _notesController.text.isNotEmpty &&
                    _notesController.text != (_originalExpense.notes ?? '')
                ? _notesController.text
                : null,
        hasReceipt: _receiptImage != null ? true : null,
        receiptUrl:
            _receiptImage != null
                ? 'https://example.com/receipt.jpg'
                : _originalExpense.receiptUrl,
      );

      await widget.expensesCubit.updateExpense(updatedExpense);

      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar despesa: $e'),
            backgroundColor: OnflyColors.alert,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _deleteExpense() async {
    setState(() {
      _isDeleting = true;
      _isSaving = false;
    });

    try {
      await widget.expensesCubit.deleteExpense(widget.expenseId);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir despesa: $e'),
            backgroundColor: OnflyColors.alert,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Despesa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Expense>(
        future: _expenseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar despesa: ${snapshot.error}',
                style: const TextStyle(color: OnflyColors.alert),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EditExpenseDetailsCard(
                    descriptionController: _descriptionController,
                    amountController: _amountController,
                    notesController: _notesController,
                    selectedDate: _selectedDate,
                    onSelectDate: () => _selectDate(context),
                    selectedCategory: _selectedCategory,
                    onCategoryChange: (val) {
                      setState(() => _selectedCategory = val);
                    },
                    receiptImage: _receiptImage,
                    onPickImage: _pickImage,
                    categories: _categories,
                  ),

                  const SizedBox(height: 16),

                  EditExpenseActions(
                    isSaving: _isSaving,
                    isDeleting: _isDeleting,
                    onSubmit: _submitForm,
                    onDelete: _deleteExpense,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
