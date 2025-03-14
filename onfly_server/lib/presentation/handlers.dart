import 'dart:convert';
import 'dart:math';

import 'package:shelf/shelf.dart';
import '../data/user_repository.dart';
import '../data/expense_repository.dart';
import '../core/jwt_service.dart';

Future<void> _simulateDelay() async {
  await Future.delayed(Duration(milliseconds: Random().nextInt(1500) + 500));
}

Future<Response> loginHandler(Request request) async {
  await _simulateDelay();
  final payload = jsonDecode(await request.readAsString());
  final email = payload['email'];
  final password = payload['password'];

  final user = await UserRepository.getUserByEmail(email);

  if (user != null && user['password'] == password) {
    final token = JwtService.generateToken(email);
    return Response.ok(
      jsonEncode({'token': token}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  return Response.forbidden(
    jsonEncode({'error': 'Invalid credentials'}),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> getExpensesHandler(Request request) async {
  await _simulateDelay();
  final expenses = await ExpenseRepository.getExpenses();
  return Response.ok(
    jsonEncode(expenses),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> addExpenseHandler(Request request) async {
  await _simulateDelay();
  final payload = jsonDecode(await request.readAsString());
  payload['id'] = DateTime.now().millisecondsSinceEpoch.toString();
  await ExpenseRepository.addExpense(payload);

  return Response.ok(
    jsonEncode(payload),
    headers: {'Content-Type': 'application/json'},
  );
}
