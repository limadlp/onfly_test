import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/data/models/expense_model.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_drift_datasource.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_remote_datasource.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesDriftDatabase localDataSource;
  final ExpensesRemoteDatasource remoteDataSource;

  ExpensesRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    try {
      final localExpenses = await localDataSource.getAllExpenses();
      final localEntities = localExpenses.map((e) => e.toEntity()).toList();

      final remoteResult = await remoteDataSource.getExpenses();
      return remoteResult.fold((failure) => Right(localEntities), (
        remoteExpenses,
      ) async {
        // Remove local records that don't exist on the server
        final localIds = localExpenses.map((e) => e.id).toSet();
        final remoteIds = remoteExpenses.map((e) => e.id).toSet();
        final orphans = localIds.difference(remoteIds);

        for (final id in orphans) {
          await localDataSource.deleteExpense(id);
        }

        for (final exp in remoteExpenses) {
          await localDataSource.upsertExpense(exp);
        }
        final updatedLocal = await localDataSource.getAllExpenses();
        return Right(updatedLocal.map((e) => e.toEntity()).toList());
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> getExpense(String id) async {
    try {
      // Try local first
      final localExpense = await localDataSource.getExpense(id);
      if (localExpense != null) {
        return Right(localExpense.toEntity());
      }
      // If not found locally, try remote
      final remoteResult = await remoteDataSource.getExpense(id);
      return remoteResult.fold((failure) => Left(failure), (
        expenseModel,
      ) async {
        // Upsert local
        await localDataSource.upsertExpense(expenseModel);
        return Right(expenseModel.toEntity());
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> addExpense(Expense expense) async {
    try {
      final tempId =
          expense.id.isEmpty
              ? 'temp_${DateTime.now().millisecondsSinceEpoch}'
              : expense.id;

      final expenseModel = ExpenseModel.fromEntity(
        expense.copyWith(id: tempId, isSynced: false),
      );

      await localDataSource.upsertExpense(expenseModel);

      final remoteResult = await remoteDataSource.addExpense(expenseModel);
      return remoteResult.fold((failure) => Right(expenseModel.toEntity()), (
        remoteExpense,
      ) async {
        // Replace temporary record
        await localDataSource.deleteExpense(tempId);
        await localDataSource.upsertExpense(
          ExpenseModel.fromEntity(remoteExpense.copyWith(isSynced: true)),
        );
        return Right(remoteExpense.toEntity());
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> updateExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      // Local
      await localDataSource.upsertExpense(expenseModel);

      // Remote
      final remoteResult = await remoteDataSource.updateExpense(expenseModel);
      return remoteResult.fold(
        (failure) {
          return Right(expenseModel.toEntity());
          // Return local if fails, still unsynced
        },
        (remoteExpense) async {
          // Upsert the updated data from remote
          await localDataSource.upsertExpense(remoteExpense);
          return Right(remoteExpense.toEntity());
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      // Delete local
      await localDataSource.deleteExpense(id);

      // Delete remote
      final remoteResult = await remoteDataSource.deleteExpense(id);
      return remoteResult.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncExpenses() async {
    try {
      final allLocalModels = await localDataSource.getAllExpenses();
      final unsynced = allLocalModels.where((m) => !m.isSynced).toList();

      for (final localModel in unsynced) {
        final isTemporary = localModel.id.startsWith('temp_');

        if (isTemporary) {
          // Process as new expense
          final addResult = await remoteDataSource.addExpense(localModel);
          await addResult.fold((failure) => null, (remoteExpense) async {
            await localDataSource.deleteExpense(localModel.id);
            await localDataSource.upsertExpense(
              ExpenseModel.fromEntity(remoteExpense.copyWith(isSynced: true)),
            );
          });
        } else {
          // Normal update
          final updateResult = await remoteDataSource.updateExpense(localModel);
          await updateResult.fold((failure) => null, (remoteExpense) async {
            await localDataSource.upsertExpense(
              ExpenseModel.fromEntity(remoteExpense.copyWith(isSynced: true)),
            );
          });
        }
      }

      // Reverse sync after upload
      final remoteResult = await remoteDataSource.getExpenses();
      return remoteResult.fold((failure) => Left(failure), (
        remoteExpenses,
      ) async {
        for (final remoteModel in remoteExpenses) {
          await localDataSource.upsertExpense(remoteModel);
        }
        // Remove local records not present on server
        final localExpenses = await localDataSource.getAllExpenses();
        final remoteIds = remoteExpenses.map((e) => e.id).toSet();
        for (final local in localExpenses) {
          if (!remoteIds.contains(local.id)) {
            await localDataSource.deleteExpense(local.id);
          }
        }
        return const Right(null);
      });
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
      // 1) Compress image with flutter_image_compress
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 50, // Adjust quality as needed (0-100)
      );
      if (compressedBytes == null) {
        throw Exception("Failed to compress image");
      }

      // Create temporary file to send
      final tempDir = imageFile.parent;
      final compressedFilePath =
          '${tempDir.path}/compressed_${imageFile.path.split('/').last}';
      final compressedFile = File(compressedFilePath)
        ..writeAsBytesSync(compressedBytes);

      // 2) Call remoteDatasource to upload file (in base64 internally)
      final remoteResult = await remoteDataSource.uploadReceipt(
        expenseId,
        compressedFile,
      );

      // 3) Handle return. If fails, return Failure
      return remoteResult.fold((failure) => Left(failure), (remoteUrl) async {
        // 4) If OK, update local:
        final localExpense = await localDataSource.getExpense(expenseId);
        if (localExpense == null) {
          // If doesn't exist locally (?), just return URL
          return Right(remoteUrl);
        }

        // Update localExpense to hasReceipt = true, receiptUrl = remoteUrl
        final updatedModel = localExpense.copyWith(
          hasReceipt: true,
          receiptUrl: remoteUrl,
          isSynced: true,
        );
        await localDataSource.upsertExpense(
          ExpenseModel.fromEntity(updatedModel),
        );
        return Right(remoteUrl);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
