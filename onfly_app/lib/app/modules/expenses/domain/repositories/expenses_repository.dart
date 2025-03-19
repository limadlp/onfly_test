import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

abstract class ExpensesRepository {
  Future<Either<Failure, List<Expense>>> getExpenses();
  Future<Either<Failure, Expense>> getExpense(String id);
  Future<Either<Failure, Expense>> addExpense(Expense expense);
  Future<Either<Failure, Expense>> updateExpense(Expense expense);
  Future<Either<Failure, void>> deleteExpense(String id);
  Future<Either<Failure, String>> uploadReceipt(
    String expenseId,
    File imageFile,
  );

  // This method tries to sync pending changes with the server
  Future<Either<Failure, void>> syncExpenses();
}
