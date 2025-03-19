import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class DeleteExpenseUsecase {
  final ExpensesRepository repository;

  DeleteExpenseUsecase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return repository.deleteExpense(id);
  }
}
