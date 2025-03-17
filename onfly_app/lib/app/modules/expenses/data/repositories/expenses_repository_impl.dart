import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_remote_datasource.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesRemoteDatasource remoteDataSource;

  ExpensesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    try {
      final result = await remoteDataSource.getExpenses();

      return result.fold(
        (failure) => Left(failure),
        (expenses) => Right(expenses),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
