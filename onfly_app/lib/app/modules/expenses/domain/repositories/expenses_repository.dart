import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

abstract class ExpensesRepository {
  Future<Either<Failure, List<Expense>>> getExpenses();
}
