class ExpenseModel {
  final String id;
  final String userId;
  final DateTime date;
  final double amount;
  final String category;
  final String description;
  final String status;
  final bool hasReceipt;
  final String notes;
  final String location;
  final String paymentMethod;
  final String approvedBy;
  final String approvedAt;
  final bool isSynced;
  final String? receiptUrl; // Permitindo ser nulo

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.status,
    required this.hasReceipt,
    required this.notes,
    required this.location,
    required this.paymentMethod,
    required this.approvedBy,
    required this.approvedAt,
    required this.isSynced,
    this.receiptUrl, // Campo opcional
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
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
      'date': date.toIso8601String(),
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
