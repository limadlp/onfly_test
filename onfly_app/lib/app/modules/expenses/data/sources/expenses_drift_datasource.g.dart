// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_drift_datasource.dart';

// ignore_for_file: type=lint
class $DriftExpensesTable extends DriftExpenses
    with TableInfo<$DriftExpensesTable, DriftExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasReceiptMeta = const VerificationMeta(
    'hasReceipt',
  );
  @override
  late final GeneratedColumn<int> hasReceipt = GeneratedColumn<int>(
    'has_receipt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _approvedByMeta = const VerificationMeta(
    'approvedBy',
  );
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
    'approved_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<String> approvedAt = GeneratedColumn<String>(
    'approved_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _receiptUrlMeta = const VerificationMeta(
    'receiptUrl',
  );
  @override
  late final GeneratedColumn<String> receiptUrl = GeneratedColumn<String>(
    'receipt_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    date,
    amount,
    category,
    description,
    status,
    hasReceipt,
    notes,
    location,
    paymentMethod,
    approvedBy,
    approvedAt,
    isSynced,
    receiptUrl,
    rejectionReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('has_receipt')) {
      context.handle(
        _hasReceiptMeta,
        hasReceipt.isAcceptableOrUnknown(data['has_receipt']!, _hasReceiptMeta),
      );
    } else if (isInserting) {
      context.missing(_hasReceiptMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('approved_by')) {
      context.handle(
        _approvedByMeta,
        approvedBy.isAcceptableOrUnknown(data['approved_by']!, _approvedByMeta),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('receipt_url')) {
      context.handle(
        _receiptUrlMeta,
        receiptUrl.isAcceptableOrUnknown(data['receipt_url']!, _receiptUrlMeta),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftExpense(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      hasReceipt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}has_receipt'],
          )!,
      notes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}notes'],
          )!,
      location:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}location'],
          )!,
      paymentMethod:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}payment_method'],
          )!,
      approvedBy:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}approved_by'],
          )!,
      approvedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}approved_at'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_synced'],
          )!,
      receiptUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}receipt_url'],
          )!,
      rejectionReason:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rejection_reason'],
          )!,
    );
  }

  @override
  $DriftExpensesTable createAlias(String alias) {
    return $DriftExpensesTable(attachedDatabase, alias);
  }
}

class DriftExpense extends DataClass implements Insertable<DriftExpense> {
  final String id;
  final String userId;
  final String date;
  final double amount;
  final String category;
  final String description;
  final String status;
  final int hasReceipt;
  final String notes;
  final String location;
  final String paymentMethod;
  final String approvedBy;
  final String approvedAt;
  final int isSynced;
  final String receiptUrl;
  final String rejectionReason;
  const DriftExpense({
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
    required this.receiptUrl,
    required this.rejectionReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<String>(date);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['status'] = Variable<String>(status);
    map['has_receipt'] = Variable<int>(hasReceipt);
    map['notes'] = Variable<String>(notes);
    map['location'] = Variable<String>(location);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['approved_by'] = Variable<String>(approvedBy);
    map['approved_at'] = Variable<String>(approvedAt);
    map['is_synced'] = Variable<int>(isSynced);
    map['receipt_url'] = Variable<String>(receiptUrl);
    map['rejection_reason'] = Variable<String>(rejectionReason);
    return map;
  }

  DriftExpensesCompanion toCompanion(bool nullToAbsent) {
    return DriftExpensesCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      amount: Value(amount),
      category: Value(category),
      description: Value(description),
      status: Value(status),
      hasReceipt: Value(hasReceipt),
      notes: Value(notes),
      location: Value(location),
      paymentMethod: Value(paymentMethod),
      approvedBy: Value(approvedBy),
      approvedAt: Value(approvedAt),
      isSynced: Value(isSynced),
      receiptUrl: Value(receiptUrl),
      rejectionReason: Value(rejectionReason),
    );
  }

  factory DriftExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftExpense(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<String>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      hasReceipt: serializer.fromJson<int>(json['hasReceipt']),
      notes: serializer.fromJson<String>(json['notes']),
      location: serializer.fromJson<String>(json['location']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      approvedBy: serializer.fromJson<String>(json['approvedBy']),
      approvedAt: serializer.fromJson<String>(json['approvedAt']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      receiptUrl: serializer.fromJson<String>(json['receiptUrl']),
      rejectionReason: serializer.fromJson<String>(json['rejectionReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<String>(date),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'status': serializer.toJson<String>(status),
      'hasReceipt': serializer.toJson<int>(hasReceipt),
      'notes': serializer.toJson<String>(notes),
      'location': serializer.toJson<String>(location),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'approvedBy': serializer.toJson<String>(approvedBy),
      'approvedAt': serializer.toJson<String>(approvedAt),
      'isSynced': serializer.toJson<int>(isSynced),
      'receiptUrl': serializer.toJson<String>(receiptUrl),
      'rejectionReason': serializer.toJson<String>(rejectionReason),
    };
  }

  DriftExpense copyWith({
    String? id,
    String? userId,
    String? date,
    double? amount,
    String? category,
    String? description,
    String? status,
    int? hasReceipt,
    String? notes,
    String? location,
    String? paymentMethod,
    String? approvedBy,
    String? approvedAt,
    int? isSynced,
    String? receiptUrl,
    String? rejectionReason,
  }) => DriftExpense(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    description: description ?? this.description,
    status: status ?? this.status,
    hasReceipt: hasReceipt ?? this.hasReceipt,
    notes: notes ?? this.notes,
    location: location ?? this.location,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    approvedBy: approvedBy ?? this.approvedBy,
    approvedAt: approvedAt ?? this.approvedAt,
    isSynced: isSynced ?? this.isSynced,
    receiptUrl: receiptUrl ?? this.receiptUrl,
    rejectionReason: rejectionReason ?? this.rejectionReason,
  );
  DriftExpense copyWithCompanion(DriftExpensesCompanion data) {
    return DriftExpense(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      hasReceipt:
          data.hasReceipt.present ? data.hasReceipt.value : this.hasReceipt,
      notes: data.notes.present ? data.notes.value : this.notes,
      location: data.location.present ? data.location.value : this.location,
      paymentMethod:
          data.paymentMethod.present
              ? data.paymentMethod.value
              : this.paymentMethod,
      approvedBy:
          data.approvedBy.present ? data.approvedBy.value : this.approvedBy,
      approvedAt:
          data.approvedAt.present ? data.approvedAt.value : this.approvedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      receiptUrl:
          data.receiptUrl.present ? data.receiptUrl.value : this.receiptUrl,
      rejectionReason:
          data.rejectionReason.present
              ? data.rejectionReason.value
              : this.rejectionReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftExpense(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('hasReceipt: $hasReceipt, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('receiptUrl: $receiptUrl, ')
          ..write('rejectionReason: $rejectionReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    date,
    amount,
    category,
    description,
    status,
    hasReceipt,
    notes,
    location,
    paymentMethod,
    approvedBy,
    approvedAt,
    isSynced,
    receiptUrl,
    rejectionReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftExpense &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.description == this.description &&
          other.status == this.status &&
          other.hasReceipt == this.hasReceipt &&
          other.notes == this.notes &&
          other.location == this.location &&
          other.paymentMethod == this.paymentMethod &&
          other.approvedBy == this.approvedBy &&
          other.approvedAt == this.approvedAt &&
          other.isSynced == this.isSynced &&
          other.receiptUrl == this.receiptUrl &&
          other.rejectionReason == this.rejectionReason);
}

class DriftExpensesCompanion extends UpdateCompanion<DriftExpense> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> date;
  final Value<double> amount;
  final Value<String> category;
  final Value<String> description;
  final Value<String> status;
  final Value<int> hasReceipt;
  final Value<String> notes;
  final Value<String> location;
  final Value<String> paymentMethod;
  final Value<String> approvedBy;
  final Value<String> approvedAt;
  final Value<int> isSynced;
  final Value<String> receiptUrl;
  final Value<String> rejectionReason;
  final Value<int> rowid;
  const DriftExpensesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.hasReceipt = const Value.absent(),
    this.notes = const Value.absent(),
    this.location = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.receiptUrl = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DriftExpensesCompanion.insert({
    required String id,
    required String userId,
    required String date,
    required double amount,
    required String category,
    required String description,
    required String status,
    required int hasReceipt,
    this.notes = const Value.absent(),
    this.location = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.receiptUrl = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       date = Value(date),
       amount = Value(amount),
       category = Value(category),
       description = Value(description),
       status = Value(status),
       hasReceipt = Value(hasReceipt);
  static Insertable<DriftExpense> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? date,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? status,
    Expression<int>? hasReceipt,
    Expression<String>? notes,
    Expression<String>? location,
    Expression<String>? paymentMethod,
    Expression<String>? approvedBy,
    Expression<String>? approvedAt,
    Expression<int>? isSynced,
    Expression<String>? receiptUrl,
    Expression<String>? rejectionReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (hasReceipt != null) 'has_receipt': hasReceipt,
      if (notes != null) 'notes': notes,
      if (location != null) 'location': location,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (receiptUrl != null) 'receipt_url': receiptUrl,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DriftExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? date,
    Value<double>? amount,
    Value<String>? category,
    Value<String>? description,
    Value<String>? status,
    Value<int>? hasReceipt,
    Value<String>? notes,
    Value<String>? location,
    Value<String>? paymentMethod,
    Value<String>? approvedBy,
    Value<String>? approvedAt,
    Value<int>? isSynced,
    Value<String>? receiptUrl,
    Value<String>? rejectionReason,
    Value<int>? rowid,
  }) {
    return DriftExpensesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      status: status ?? this.status,
      hasReceipt: hasReceipt ?? this.hasReceipt,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      isSynced: isSynced ?? this.isSynced,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (hasReceipt.present) {
      map['has_receipt'] = Variable<int>(hasReceipt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<String>(approvedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (receiptUrl.present) {
      map['receipt_url'] = Variable<String>(receiptUrl.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftExpensesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('hasReceipt: $hasReceipt, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('receiptUrl: $receiptUrl, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ExpensesDriftDatabase extends GeneratedDatabase {
  _$ExpensesDriftDatabase(QueryExecutor e) : super(e);
  $ExpensesDriftDatabaseManager get managers =>
      $ExpensesDriftDatabaseManager(this);
  late final $DriftExpensesTable driftExpenses = $DriftExpensesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [driftExpenses];
}

typedef $$DriftExpensesTableCreateCompanionBuilder =
    DriftExpensesCompanion Function({
      required String id,
      required String userId,
      required String date,
      required double amount,
      required String category,
      required String description,
      required String status,
      required int hasReceipt,
      Value<String> notes,
      Value<String> location,
      Value<String> paymentMethod,
      Value<String> approvedBy,
      Value<String> approvedAt,
      Value<int> isSynced,
      Value<String> receiptUrl,
      Value<String> rejectionReason,
      Value<int> rowid,
    });
typedef $$DriftExpensesTableUpdateCompanionBuilder =
    DriftExpensesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> date,
      Value<double> amount,
      Value<String> category,
      Value<String> description,
      Value<String> status,
      Value<int> hasReceipt,
      Value<String> notes,
      Value<String> location,
      Value<String> paymentMethod,
      Value<String> approvedBy,
      Value<String> approvedAt,
      Value<int> isSynced,
      Value<String> receiptUrl,
      Value<String> rejectionReason,
      Value<int> rowid,
    });

class $$DriftExpensesTableFilterComposer
    extends Composer<_$ExpensesDriftDatabase, $DriftExpensesTable> {
  $$DriftExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasReceipt => $composableBuilder(
    column: $table.hasReceipt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftExpensesTableOrderingComposer
    extends Composer<_$ExpensesDriftDatabase, $DriftExpensesTable> {
  $$DriftExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasReceipt => $composableBuilder(
    column: $table.hasReceipt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftExpensesTableAnnotationComposer
    extends Composer<_$ExpensesDriftDatabase, $DriftExpensesTable> {
  $$DriftExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get hasReceipt => $composableBuilder(
    column: $table.hasReceipt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );
}

class $$DriftExpensesTableTableManager
    extends
        RootTableManager<
          _$ExpensesDriftDatabase,
          $DriftExpensesTable,
          DriftExpense,
          $$DriftExpensesTableFilterComposer,
          $$DriftExpensesTableOrderingComposer,
          $$DriftExpensesTableAnnotationComposer,
          $$DriftExpensesTableCreateCompanionBuilder,
          $$DriftExpensesTableUpdateCompanionBuilder,
          (
            DriftExpense,
            BaseReferences<
              _$ExpensesDriftDatabase,
              $DriftExpensesTable,
              DriftExpense
            >,
          ),
          DriftExpense,
          PrefetchHooks Function()
        > {
  $$DriftExpensesTableTableManager(
    _$ExpensesDriftDatabase db,
    $DriftExpensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$DriftExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DriftExpensesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> hasReceipt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> approvedBy = const Value.absent(),
                Value<String> approvedAt = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<String> receiptUrl = const Value.absent(),
                Value<String> rejectionReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DriftExpensesCompanion(
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
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String date,
                required double amount,
                required String category,
                required String description,
                required String status,
                required int hasReceipt,
                Value<String> notes = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> approvedBy = const Value.absent(),
                Value<String> approvedAt = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<String> receiptUrl = const Value.absent(),
                Value<String> rejectionReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DriftExpensesCompanion.insert(
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
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$ExpensesDriftDatabase,
      $DriftExpensesTable,
      DriftExpense,
      $$DriftExpensesTableFilterComposer,
      $$DriftExpensesTableOrderingComposer,
      $$DriftExpensesTableAnnotationComposer,
      $$DriftExpensesTableCreateCompanionBuilder,
      $$DriftExpensesTableUpdateCompanionBuilder,
      (
        DriftExpense,
        BaseReferences<
          _$ExpensesDriftDatabase,
          $DriftExpensesTable,
          DriftExpense
        >,
      ),
      DriftExpense,
      PrefetchHooks Function()
    >;

class $ExpensesDriftDatabaseManager {
  final _$ExpensesDriftDatabase _db;
  $ExpensesDriftDatabaseManager(this._db);
  $$DriftExpensesTableTableManager get driftExpenses =>
      $$DriftExpensesTableTableManager(_db, _db.driftExpenses);
}
