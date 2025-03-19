import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/add_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/delete_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/update_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/upload_receipt_usecase.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUsecase getExpensesUsecase;
  final GetExpenseUsecase getExpenseUsecase;
  final AddExpenseUsecase addExpenseUsecase;
  final UpdateExpenseUsecase updateExpenseUsecase;
  final DeleteExpenseUsecase deleteExpenseUsecase;
  final UploadReceiptUsecase uploadReceiptUsecase;

  ExpensesCubit({
    required this.getExpensesUsecase,
    required this.getExpenseUsecase,
    required this.addExpenseUsecase,
    required this.updateExpenseUsecase,
    required this.deleteExpenseUsecase,
    required this.uploadReceiptUsecase,
  }) : super(const ExpensesState()) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    final result = await getExpensesUsecase();
    result.fold(
      (failure) {
        log(failure.message);
        emit(
          state.copyWith(
            status: ExpensesStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (expenses) {
        final expensesByCategory = _calculateExpensesByCategory(expenses);
        emit(
          state.copyWith(
            expenses: expenses,
            status: ExpensesStatus.loaded,
            expensesByCategory: expensesByCategory,
          ),
        );
      },
    );
  }

  Future<Expense> getExpense(String id) async {
    final result = await getExpenseUsecase(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (expense) => expense,
    );
  }

  void setFilter(ExpenseFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> addExpense(Expense expense) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    final result = await addExpenseUsecase(expense);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ExpensesStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (addedExpense) async {
        // Reload the list from local (or you can just add in memory)
        await loadExpenses();
      },
    );
  }

  Future<void> updateExpense(Expense expense) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    final result = await updateExpenseUsecase(expense);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ExpensesStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (updatedExpense) {
        // Update in memory
        final updatedExpenses =
            state.expenses.map((e) {
              return e.id == updatedExpense.id ? updatedExpense : e;
            }).toList();
        final expensesByCategory = _calculateExpensesByCategory(
          updatedExpenses,
        );
        emit(
          state.copyWith(
            expenses: updatedExpenses,
            status: ExpensesStatus.loaded,
            expensesByCategory: expensesByCategory,
          ),
        );
      },
    );
  }

  Future<void> deleteExpense(String id) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    final result = await deleteExpenseUsecase(id);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ExpensesStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        final newList = state.expenses.where((e) => e.id != id).toList();
        emit(
          state.copyWith(
            expenses: newList,
            status: ExpensesStatus.loaded,
            expensesByCategory: _calculateExpensesByCategory(newList),
          ),
        );
      },
    );
  }

  Map<String, double> _calculateExpensesByCategory(List<Expense> expenses) {
    final result = <String, double>{};
    for (final expense in expenses) {
      result[expense.category] =
          (result[expense.category] ?? 0) + expense.amount;
    }
    return result;
  }

  Future<void> pickAndUploadReceipt(String expenseId) async {
    try {
      emit(state.copyWith(status: ExpensesStatus.loading));

      // 1) Pick image from gallery
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked == null) {
        // user canceled, do nothing
        emit(state.copyWith(status: ExpensesStatus.loaded));
        return;
      }

      final file = File(picked.path);

      // 2) Compress image
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 50,
      );
      if (compressedBytes == null) {
        emit(
          state.copyWith(
            status: ExpensesStatus.error,
            errorMessage: "Failed to compress image",
          ),
        );
        return;
      }
      // Create a temporary file with the compressed data or convert in memory
      final tempDir = file.parent;
      final compressedFilePath =
          '${tempDir.path}/compressed_${file.path.split('/').last}';
      final compressedFile = File(compressedFilePath)
        ..writeAsBytesSync(compressedBytes);

      // 3) Upload receipt
      final result = await uploadReceiptUsecase(expenseId, compressedFile);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ExpensesStatus.error,
              errorMessage: failure.message,
            ),
          );
        },
        (newReceiptUrl) {
          // 4) We can update the expense in memory to reflect new receipt
          final updatedExpenses =
              state.expenses.map((exp) {
                if (exp.id == expenseId) {
                  return exp.copyWith(
                    hasReceipt: true,
                    receiptUrl: newReceiptUrl,
                  );
                }
                return exp;
              }).toList();

          emit(
            state.copyWith(
              status: ExpensesStatus.loaded,
              expenses: updatedExpenses,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpensesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addExpenseWithReceipt({
    required Expense expense,
    required File? receiptFile,
  }) async {
    await addExpense(expense);

    if (receiptFile != null) {
      await uploadReceiptUsecase(expense.id, receiptFile);
    }
  }
}
