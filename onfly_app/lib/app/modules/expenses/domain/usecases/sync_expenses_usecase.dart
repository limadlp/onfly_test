import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class SyncExpensesUsecase {
  final ExpensesRepository repository;

  SyncExpensesUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    return repository.syncExpenses();
  }
}
