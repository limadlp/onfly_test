class ExpenseModel {
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

  ExpenseModel({
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

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      hasReceipt: json['hasReceipt'] ?? false,
      notes: json['notes'] ?? '',
      location: json['location'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'OTHER',
      approvedBy: json['approvedBy'] ?? '',
      approvedAt: json['approvedAt'] ?? '',
      isSynced: json['isSynced'] ?? false,
      receiptUrl: json['receiptUrl'],
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
    };
  }
}
