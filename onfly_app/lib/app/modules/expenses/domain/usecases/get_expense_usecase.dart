import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class GetExpenseUsecase {
  final ExpensesRepository repository;

  GetExpenseUsecase(this.repository);

  Future<Either<Failure, Expense>> call(String id) async {
    return repository.getExpense(id);
  }
}
