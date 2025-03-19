import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.amount,
    required super.category,
    required super.description,
    required super.status,
    required super.hasReceipt,
    super.notes,
    super.location,
    super.paymentMethod,
    super.approvedBy,
    super.approvedAt,
    required super.isSynced,
    super.receiptUrl,
    super.rejectionReason,
  });

  bool get isTemporary => id.startsWith('temp_');

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      category: json['category'],
      description: json['description'],
      status: json['status'],
      hasReceipt: json['hasReceipt'] ?? false,
      notes: json['notes'],
      location: json['location'],
      paymentMethod: json['paymentMethod'],
      approvedBy: json['approvedBy'],
      approvedAt: json['approvedAt'],
      isSynced: json['isSynced'] ?? false,
      receiptUrl: json['receiptUrl'],
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'amount': amount,
      'category': category,
      'description': description,
      'status': status,
      'hasReceipt': hasReceipt,
      'notes': notes,
      'location': location,
      'paymentMethod': paymentMethod,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt,
      'isSynced': isSynced,
      'receiptUrl': receiptUrl,
      'rejectionReason': rejectionReason,
    };
  }

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      userId: expense.userId,
      date: expense.date,
      amount: expense.amount,
      category: expense.category,
      description: expense.description,
      status: expense.status,
      hasReceipt: expense.hasReceipt,
      notes: expense.notes,
      location: expense.location,
      paymentMethod: expense.paymentMethod,
      approvedBy: expense.approvedBy,
      approvedAt: expense.approvedAt,
      isSynced: expense.isSynced,
      receiptUrl: expense.receiptUrl,
      rejectionReason: expense.rejectionReason,
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      userId: userId,
      date: date,
      amount: amount,
      category: category,
      description: description,
      status: status,
      hasReceipt: hasReceipt,
      notes: notes,
      location: location,
      paymentMethod: paymentMethod,
      approvedBy: approvedBy,
      approvedAt: approvedAt,
      isSynced: isSynced,
      receiptUrl: receiptUrl,
      rejectionReason: rejectionReason,
    );
  }
}
