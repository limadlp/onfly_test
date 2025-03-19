import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class UpdateExpenseUsecase {
  final ExpensesRepository repository;

  UpdateExpenseUsecase(this.repository);

  Future<Either<Failure, Expense>> call(Expense expense) async {
    return repository.updateExpense(expense);
  }
}
