// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:onfly_app/app/modules/expenses/data/models/expense_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'expenses_drift_datasource.g.dart';

class DriftExpenses extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get date => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  TextColumn get status => text()();
  IntColumn get hasReceipt => integer()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get paymentMethod => text().withDefault(const Constant(''))();
  TextColumn get approvedBy => text().withDefault(const Constant(''))();
  TextColumn get approvedAt => text().withDefault(const Constant(''))();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  TextColumn get receiptUrl => text().withDefault(const Constant(''))();
  TextColumn get rejectionReason => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [DriftExpenses])
class ExpensesDriftDatabase extends _$ExpensesDriftDatabase {
  ExpensesDriftDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> upsertExpense(ExpenseModel expenseModel) async {
    final driftExpense = DriftExpensesCompanion(
      id: Value(expenseModel.id),
      userId: Value(expenseModel.userId),
      date: Value(expenseModel.date),
      amount: Value(expenseModel.amount),
      category: Value(expenseModel.category),
      description: Value(expenseModel.description),
      status: Value(expenseModel.status),
      hasReceipt: Value(expenseModel.hasReceipt ? 1 : 0),
      notes: Value(expenseModel.notes ?? ''),
      location: Value(expenseModel.location ?? ''),
      paymentMethod: Value(expenseModel.paymentMethod ?? ''),
      approvedBy: Value(expenseModel.approvedBy ?? ''),
      approvedAt: Value(expenseModel.approvedAt ?? ''),
      isSynced: Value(expenseModel.isSynced ? 1 : 0),
      receiptUrl: Value(expenseModel.receiptUrl ?? ''),
      rejectionReason: Value(expenseModel.rejectionReason ?? ''),
    );

    await into(driftExpenses).insertOnConflictUpdate(driftExpense);
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final rows = await select(driftExpenses).get();
    return rows.map((row) => _mapToModel(row)).toList();
  }

  Future<ExpenseModel?> getExpense(String id) async {
    final row =
        await (select(driftExpenses)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _mapToModel(row);
  }

  Future<void> deleteExpense(String id) async {
    await (delete(driftExpenses)..where((tbl) => tbl.id.equals(id))).go();
  }

  ExpenseModel _mapToModel(DriftExpense data) {
    return ExpenseModel(
      id: data.id,
      userId: data.userId,
      date: data.date,
      amount: data.amount,
      category: data.category,
      description: data.description,
      status: data.status,
      hasReceipt: data.hasReceipt == 1,
      notes: data.notes,
      location: data.location,
      paymentMethod: data.paymentMethod,
      approvedBy: data.approvedBy,
      approvedAt: data.approvedAt,
      isSynced: data.isSynced == 1,
      receiptUrl: data.receiptUrl,
      rejectionReason: data.rejectionReason,
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'expenses.sqlite'));
    return NativeDatabase(file);
  });
}
