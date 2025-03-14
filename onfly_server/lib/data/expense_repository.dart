import 'package:onfly_api/core/database_helper.dart';

class ExpenseRepository {
  static Future<List<Map<String, dynamic>>> getExpenses() async {
    return await DatabaseHelper.getCollection('expenses');
  }

  static Future<void> addExpense(Map<String, dynamic> expense) async {
    await DatabaseHelper.addToCollection('expenses', expense);
  }
}
