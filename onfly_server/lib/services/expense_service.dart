import 'package:onfly_api/models/expense_model.dart';
import 'package:onfly_api/repositories/auth_repository.dart';
import 'package:onfly_api/repositories/expense_repository.dart';

class ExpenseService {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final AuthRepository _authRepository = AuthRepository();

  /// Retrieves all expenses for the logged-in user (filtered by email)
  Future<List<ExpenseModel>> getExpensesByEmail(String email) async {
    final user = await _authRepository.getUserByEmail(email);
    if (user == null) return [];

    final allExpenses = await _expenseRepository.getExpenses();
    return allExpenses.where((e) => e.userId == user.id).toList();
  }

  /// Retrieves a single expense by ID
  Future<ExpenseModel?> getExpenseById(String id) async {
    return await _expenseRepository.getExpenseById(id);
  }

  /// Adds a new expense
  Future<void> addExpense(ExpenseModel expense) async {
    await _expenseRepository.addExpense(expense);
  }

  /// Updates an existing expense
  Future<void> updateExpense(String id, ExpenseModel updatedExpense) async {
    await _expenseRepository.updateExpense(id, updatedExpense);
  }

  /// Deletes an expense by ID
  Future<void> deleteExpense(String id) async {
    await _expenseRepository.deleteExpense(id);
  }
}
