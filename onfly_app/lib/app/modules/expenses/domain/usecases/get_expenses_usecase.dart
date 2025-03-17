import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class GetExpensesUsecase {
  final ExpensesRepository repository;

  GetExpensesUsecase(this.repository);

  Future<Either<Failure, List<Expense>>> call() async {
    return await repository.getExpenses();
  }
}
