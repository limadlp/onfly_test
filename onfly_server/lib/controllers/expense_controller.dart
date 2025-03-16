import 'dart:convert';
import 'package:onfly_api/utils/image_service.dart';
import 'package:shelf/shelf.dart';
import 'package:onfly_api/services/expense_service.dart';
import 'package:onfly_api/models/expense_model.dart';

class ExpenseController {
  final ExpenseService _expenseService = ExpenseService();
  final ImageService _imageService = ImageService();

  Future<Response> getAllExpenses(Request request) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final expenses = await _expenseService.getExpensesByEmail(email);
    return Response.ok(
      jsonEncode(expenses.map((e) => e.toJson()).toList()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> getExpenseById(Request request, String id) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final expense = await _expenseService.getExpenseById(id);
    if (expense == null || expense.userId != email) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized or not found'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    return Response.ok(
      jsonEncode(expense.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> addExpense(Request request) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final payload = jsonDecode(await request.readAsString());

    final newExpense = ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: email,
      date: DateTime.parse(payload['date']),
      value: payload['value'].toDouble(),
      category: payload['category'],
      description: payload['description'],
      isSynced: false,
      receiptPath: payload['receiptPath'],
    );

    await _expenseService.addExpense(newExpense);
    return Response.ok(
      jsonEncode(newExpense.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> updateExpense(Request request, String id) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final payload = jsonDecode(await request.readAsString());
    final existingExpense = await _expenseService.getExpenseById(id);

    if (existingExpense == null || existingExpense.userId != email) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized or not found'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final updatedExpense = ExpenseModel(
      id: id,
      userId: existingExpense.userId,
      date: DateTime.parse(payload['date']),
      value: payload['value'].toDouble(),
      category: payload['category'],
      description: payload['description'],
      isSynced: true,
      receiptPath: payload['receiptPath'] ?? existingExpense.receiptPath,
    );

    await _expenseService.updateExpense(id, updatedExpense);
    return Response.ok(
      jsonEncode({'message': 'Expense updated successfully'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> deleteExpense(Request request, String id) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final existingExpense = await _expenseService.getExpenseById(id);
    if (existingExpense == null || existingExpense.userId != email) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized or not found'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    await _expenseService.deleteExpense(id);
    return Response.ok(
      jsonEncode({'message': 'Expense deleted successfully'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> uploadReceipt(Request request) async {
    final email = request.context['email'] as String?;
    if (email == null) {
      return Response.forbidden(
        jsonEncode({'error': 'Unauthorized'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    try {
      final payload = jsonDecode(await request.readAsString());

      if (!payload.containsKey('imageBase64') ||
          !payload.containsKey('filename') ||
          !payload.containsKey('expenseId')) {
        return Response.badRequest(
          body: jsonEncode({
            'error': 'Missing imageBase64, filename, or expenseId',
          }),
          headers: {'Content-Type': 'application/json'},
        );
      }

      final expenseId = payload['expenseId'] as String;
      final base64String = payload['imageBase64'] as String;
      final cleanedBase64 = cleanBase64(base64String);
      final fileBytes = base64Decode(cleanedBase64);
      final filename = payload['filename'] as String;

      final filePath = await _imageService.saveImage(fileBytes, filename);

      final existingExpense = await _expenseService.getExpenseById(expenseId);
      if (existingExpense == null || existingExpense.userId != email) {
        return Response.forbidden(
          jsonEncode({'error': 'Unauthorized or expense not found'}),
          headers: {'Content-Type': 'application/json'},
        );
      }

      final updatedExpense = ExpenseModel(
        id: existingExpense.id,
        userId: existingExpense.userId,
        date: existingExpense.date,
        value: existingExpense.value,
        category: existingExpense.category,
        description: existingExpense.description,
        isSynced: false,
        receiptPath: filePath,
      );

      await _expenseService.updateExpense(expenseId, updatedExpense);

      return Response.ok(
        jsonEncode({
          'message': 'Receipt uploaded successfully',
          'filePath': filePath,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      print('❌ Error processing image upload: $e');
      return Response.internalServerError(
        body: jsonEncode({'error': 'Failed to save image'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  String cleanBase64(String base64String) {
    // Remove Data URI prefix if exists
    final regex = RegExp(r'data:image/[^;]+;base64,');
    return base64String.replaceAll(regex, '');
  }
}
