class Expense {
  final String id;
  final String userId;
  final String date;
  final double amount;
  final String category;
  final String description;
  final String status;
  final String notes;
  final String location;
  final String paymentMethod;
  final String? approvedBy;
  final String? approvedAt;
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
    required this.notes,
    required this.location,
    required this.paymentMethod,
    required this.approvedBy,
    required this.approvedAt,
    required this.isSynced,
    required this.hasReceipt,
    this.receiptUrl,
  });
}
