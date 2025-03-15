import '../utils/database_helper.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<ExpenseModel>> getExpenses() async {
    final expenses = await _dbHelper.getCollection('expenses');
    return expenses.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  Future<ExpenseModel?> getExpenseById(String id) async {
    final expenses = await _dbHelper.getCollection('expenses');
    final expenseData = expenses.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (expenseData.isEmpty) return null;
    return ExpenseModel.fromJson(expenseData);
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await _dbHelper.addToCollection('expenses', expense.toJson());
  }

  Future<void> updateExpense(String id, ExpenseModel expense) async {
    await _dbHelper.updateCollection('expenses', id, expense.toJson());
  }

  Future<void> deleteExpense(String id) async {
    await _dbHelper.deleteFromCollection('expenses', id);
  }
}
