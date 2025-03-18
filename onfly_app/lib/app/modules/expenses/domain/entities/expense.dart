// ignore_for_file: public_member_api_docs, sort_constructors_first
class Expense {
  final String id;
  final String userId;
  final String date;
  final double amount;
  final String category;
  final String description;
  final String status;
  final String? notes;
  final String? location;
  final String? paymentMethod;
  final String? approvedBy;
  final String? approvedAt;
  final String? rejectionReason;
  final bool isSynced;
  final bool hasReceipt;
  final String? receiptUrl;

  Expense({
    required this.id,
    required this.userId,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.status,
    this.notes,
    this.location,
    this.paymentMethod,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    required this.isSynced,
    required this.hasReceipt,
    this.receiptUrl,
  });

  Expense copyWith({
    String? id,
    String? userId,
    String? date,
    double? amount,
    String? category,
    String? description,
    String? status,
    String? notes,
    String? location,
    String? paymentMethod,
    String? approvedBy,
    String? approvedAt,
    String? rejectionReason,
    bool? isSynced,
    bool? hasReceipt,
    String? receiptUrl,
  }) {
    return Expense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isSynced: isSynced ?? this.isSynced,
      hasReceipt: hasReceipt ?? this.hasReceipt,
      receiptUrl: receiptUrl ?? this.receiptUrl,
    );
  }
}
