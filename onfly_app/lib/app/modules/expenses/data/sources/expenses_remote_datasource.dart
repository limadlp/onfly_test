import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/data/models/expense_model.dart';

abstract class ExpensesRemoteDatasource {
  Future<Either<Failure, List<ExpenseModel>>> getExpenses();
}

class ExpensesRemoteDatasourceImpl implements ExpensesRemoteDatasource {
  final ApiClient apiClient;

  ExpensesRemoteDatasourceImpl(this.apiClient);

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpenses() async {
    try {
      final response = await apiClient.get(ApiUrl.expenses);

      final List<ExpenseModel> expenses =
          (response as List)
              .map((expense) => ExpenseModel.fromJson(expense))
              .toList();

      return Right(expenses);
    } on ApiClientException catch (e) {
      if (e.statusCode == 401) {
        return Left(InvalidCredentialsFailure());
      } else if (e.statusCode == 400 || e.statusCode == 409) {
        return Left(ServerFailure(e.message));
      }
      return Left(
        ServerFailure('HTTP Error ${e.statusCode ?? "unknown"}: ${e.message}'),
      );
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
