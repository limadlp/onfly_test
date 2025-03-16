import 'dart:convert';

class ExpenseModel {
  final String id;
  final String userId;
  final DateTime date;
  final double value;
  final String category;
  final String description;
  final bool isSynced;
  final String? receiptPath;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.value,
    required this.category,
    required this.description,
    required this.isSynced,
    this.receiptPath,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      value: json['value'].toDouble(),
      category: json['category'],
      description: json['description'],
      isSynced: json['isSynced'],
      receiptPath: json['receiptPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'value': value,
      'category': category,
      'description': description,
      'isSynced': isSynced,
      'receiptPath': receiptPath,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
