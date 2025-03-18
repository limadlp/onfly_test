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
    required super.notes,
    required super.location,
    required super.paymentMethod,
    required super.approvedBy,
    required super.approvedAt,
    required super.isSynced,
    required super.hasReceipt,
    super.receiptUrl,
    required super.rejectionReason,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      amount: json['amount'],
      category: json['category'],
      description: json['description'],
      status: json['status'],
      notes: json['notes'],
      location: json['location'],
      paymentMethod: json['paymentMethod'],
      approvedBy: json['approvedBy'],
      approvedAt: json['approvedAt'],
      isSynced: json['isSynced'],
      hasReceipt: json['hasReceipt'],
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
      'notes': notes,
      'location': location,
      'paymentMethod': paymentMethod,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt,
      'isSynced': isSynced,
      'hasReceipt': hasReceipt,
      'receiptUrl': receiptUrl,
      'rejectionReason': rejectionReason,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          date == other.date &&
          amount == other.amount &&
          category == other.category &&
          description == other.description &&
          status == other.status &&
          notes == other.notes &&
          location == other.location &&
          paymentMethod == other.paymentMethod &&
          approvedBy == other.approvedBy &&
          approvedAt == other.approvedAt &&
          isSynced == other.isSynced &&
          hasReceipt == other.hasReceipt &&
          receiptUrl == other.receiptUrl &&
          rejectionReason == other.rejectionReason;

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    date,
    amount,
    category,
    description,
    status,
    notes,
    location,
    paymentMethod,
    approvedBy,
    approvedAt,
    isSynced,
    hasReceipt,
    receiptUrl,
    rejectionReason,
  );
}
