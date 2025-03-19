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
      // 1) Get local data
      final localExpenses = await localDataSource.getAllExpenses();
      final localEntities = localExpenses.map((e) => e.toEntity()).toList();

      // 2) Try to get remote data
      final remoteResult = await remoteDataSource.getExpenses();
      return remoteResult.fold(
        // If fails, return local data
        (failure) => Right(localEntities),
        (remoteExpenses) async {
          // If success, upsert into local db and return
          for (final exp in remoteExpenses) {
            await localDataSource.upsertExpense(exp);
          }
          final updatedLocal = await localDataSource.getAllExpenses();
          return Right(updatedLocal.map((e) => e.toEntity()).toList());
        },
      );
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
      // Insert locally with isSynced = false, generate an ID if needed
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final expenseModel = ExpenseModel.fromEntity(
        expense.copyWith(id: expense.id.isEmpty ? tempId : expense.id),
      );
      await localDataSource.upsertExpense(expenseModel);

      // Try remote
      final remoteResult = await remoteDataSource.addExpense(expenseModel);
      return remoteResult.fold(
        (failure) {
          return Right(expenseModel.toEntity());
          // Return local if fails, but with isSynced = false
        },
        (remoteExpense) async {
          // Update local with the remote data (id, etc)
          await localDataSource.upsertExpense(remoteExpense);
          return Right(remoteExpense.toEntity());
        },
      );
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

  // TODO: see

  @override
  Future<Either<Failure, void>> syncExpenses() async {
    try {
      // 1) Busca todas as despesas locais (retorna List<ExpenseModel>)
      final allLocalModels = await localDataSource.getAllExpenses();

      // 2) Filtra apenas as que não estão sincronizadas
      final unsynced =
          allLocalModels.where((m) => m.isSynced == false).toList();

      // 3) Para cada despesa local não sincronizada, tenta sincronizar com o servidor
      for (final localModel in unsynced) {
        // Verifica se essa despesa existe no backend (pelo ID) para decidir se é "add" ou "update"
        final remoteGetResult = await remoteDataSource.getExpense(
          localModel.id,
        );

        await remoteGetResult.fold(
          // Se não encontrou ou ocorreu alguma falha (ex: 404), tentamos fazer addExpense
          (failure) async {
            final addResult = await remoteDataSource.addExpense(localModel);
            addResult.fold(
              (failure) => null, // Se falhar novamente, deixamos como está
              (addedModel) async {
                // Se adicionou com sucesso, marca local como sincronizado
                await localDataSource.upsertExpense(
                  ExpenseModel.fromEntity(addedModel.copyWith(isSynced: true)),
                );
              },
            );
          },
          // Se a despesa foi encontrada no backend, fazemos updateExpense
          (foundRemoteModel) async {
            final updateResult = await remoteDataSource.updateExpense(
              localModel,
            );
            updateResult.fold((failure) => null, (updatedModel) async {
              // Se update ok, marca local como sincronizado
              await localDataSource.upsertExpense(
                ExpenseModel.fromEntity(updatedModel.copyWith(isSynced: true)),
              );
            });
          },
        );
      }

      // 4) Ao final, chamamos getExpenses() remoto para atualizar nosso local
      final remoteResult = await remoteDataSource.getExpenses();
      return remoteResult.fold((failure) => Left(failure), (
        remoteExpenses,
      ) async {
        // Sobrescreve local com a lista vinda do servidor
        for (final remoteModel in remoteExpenses) {
          await localDataSource.upsertExpense(remoteModel);
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
      // 1) Comprime a imagem com flutter_image_compress
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 50, // Ajuste o quality conforme necessidade (0-100)
      );
      if (compressedBytes == null) {
        throw Exception("Failed to compress image");
      }

      // Cria um arquivo temporário para enviar
      final tempDir = imageFile.parent;
      final compressedFilePath =
          '${tempDir.path}/compressed_${imageFile.path.split('/').last}';
      final compressedFile = File(compressedFilePath)
        ..writeAsBytesSync(compressedBytes);

      // 2) Chama o remoteDatasource para fazer upload do arquivo (em base64 por dentro)
      final remoteResult = await remoteDataSource.uploadReceipt(
        expenseId,
        compressedFile,
      );

      // 3) Trata o retorno. Se falhar, retorne a Failure
      return remoteResult.fold((failure) => Left(failure), (remoteUrl) async {
        // 4) Se OK, atualiza local:
        final localExpense = await localDataSource.getExpense(expenseId);
        if (localExpense == null) {
          // Se não existe localmente (?), só retorna a URL
          return Right(remoteUrl);
        }

        // Atualiza o localExpense para hasReceipt = true, receiptUrl = remoteUrl
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
