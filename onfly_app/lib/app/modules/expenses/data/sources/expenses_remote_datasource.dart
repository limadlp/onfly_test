import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/data/models/expense_model.dart';

abstract class ExpensesRemoteDatasource {
  Future<Either<Failure, List<ExpenseModel>>> getExpenses();
  Future<Either<Failure, ExpenseModel>> getExpense(String id);
  Future<Either<Failure, ExpenseModel>> addExpense(ExpenseModel expense);
  Future<Either<Failure, ExpenseModel>> updateExpense(ExpenseModel expense);
  Future<Either<Failure, void>> deleteExpense(String id);
  Future<Either<Failure, String>> uploadReceipt(
    String expenseId,
    File imageFile,
  );
}

class ExpensesRemoteDatasourceImpl implements ExpensesRemoteDatasource {
  final ApiClient apiClient;

  ExpensesRemoteDatasourceImpl(this.apiClient);

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpenses() async {
    try {
      final response = await apiClient.get(ApiUrl.expenses);
      final List<dynamic> dataList = response is List ? response : [];
      final expenses = dataList.map((e) => ExpenseModel.fromJson(e)).toList();
      return Right(expenses);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> getExpense(String id) async {
    try {
      final response = await apiClient.get('${ApiUrl.expenses}/$id');
      final expense = ExpenseModel.fromJson(response);
      return Right(expense);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> addExpense(ExpenseModel expense) async {
    try {
      final response = await apiClient.post(
        ApiUrl.expenses,
        data: expense.toJson(),
      );
      final newExpense = ExpenseModel.fromJson(response);
      return Right(newExpense);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> updateExpense(
    ExpenseModel expense,
  ) async {
    try {
      final response = await apiClient.put(
        '${ApiUrl.expenses}/${expense.id}',
        data: expense.toJson(),
      );
      final updatedExpense = ExpenseModel.fromJson(response);
      return Right(updatedExpense);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await apiClient.delete('${ApiUrl.expenses}/$id');
      return const Right(null);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadReceipt(
    String expenseId,
    File imageFile,
  ) async {
    try {
      // We'll convert the file to base64. Usually you compress first (below).
      // Suppose we've already compressed before calling here. Or we do inside. We'll keep it direct here.
      final bytes = await imageFile.readAsBytes();
      final base64String = base64Encode(bytes);

      // For server usage, we need a filename. For instance:
      final filename = imageFile.path.split('/').last;

      final data = {
        'expenseId': expenseId,
        'imageBase64': base64String,
        'filename': filename,
      };

      final response = await apiClient.post(
        '${ApiUrl.expenses}/upload',
        data: data,
      );

      // The server typically returns { "filePath": "...", "message": "..."}
      // We'll parse "filePath" as the new remote URL
      final newUrl = response['filePath'] as String;
      return Right(newUrl);
    } on ApiClientException catch (e) {
      return Left(ServerFailure('${e.statusCode}: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
