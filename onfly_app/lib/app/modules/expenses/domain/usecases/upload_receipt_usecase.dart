import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';

class UploadReceiptUsecase {
  final ExpensesRepository repository;

  UploadReceiptUsecase(this.repository);

  Future<Either<Failure, String>> call(String expenseId, File imageFile) async {
    return repository.uploadReceipt(expenseId, imageFile);
  }
}
