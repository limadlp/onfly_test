import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

//TODO: Move to Usecase
class ExpenseService {
  // Mock data for expenses
  final List<Expense> _mockExpenses = [
    Expense(
      id: '1',
      description: 'Almoço com cliente',
      amount: 225, // in cents
      date: '2023-11-15',
      category: 'Alimentação',
      status: 'approved',
      hasReceipt: true,
      notes: 'Reunião com cliente para discutir novo projeto',
      location: 'Restaurante Oliveira, São Paulo',
      paymentMethod: 'Cartão corporativo',
      approvedBy: 'Carlos Silva',
      approvedAt: '2023-11-15',
      userId: '1',
      isSynced: false,
      rejectionReason: '',
    ),
    Expense(
      id: '2',
      description: 'Táxi para o aeroporto',
      amount: 187.50, // in cents
      date: '2023-11-14',
      category: 'Transporte',
      status: 'pending',
      hasReceipt: true,
      notes: 'Viagem para reunião em São Paulo',
      location: 'Rio de Janeiro → Aeroporto Santos Dumont',
      paymentMethod: 'Dinheiro',
      approvedBy: '',
      approvedAt: '',
      userId: '1',
      isSynced: false,
      rejectionReason: '',
    ),
    Expense(
      id: '3',
      description: 'Hotel em São Paulo',
      amount: 450, // in cents
      date: '2023-11-10',
      category: 'Hospedagem',
      status: 'approved',
      hasReceipt: true,
      notes: 'Estadia de 2 noites para conferência',
      location: 'Hotel Business Plaza, São Paulo',
      paymentMethod: 'Cartão corporativo',
      approvedBy: 'Ana Oliveira',
      approvedAt: '2023-11-11',
      userId: '1',
      isSynced: false,
      rejectionReason: '',
    ),
    Expense(
      id: '4',
      description: 'Passagem aérea',
      amount: 800, // in cents
      date: '2023-11-05',
      category: 'Transporte',
      status: 'rejected',
      hasReceipt: false,
      notes: 'Viagem para conferência anual',
      location: 'Rio de Janeiro → São Paulo',
      paymentMethod: 'Cartão corporativo',
      approvedBy: '',
      approvedAt: '',
      userId: '1',
      isSynced: false,
      rejectionReason: '',
    ),
    Expense(
      id: '5',
      description: 'Festa aérea',
      amount: 70, // in cents
      date: '2023-11-05',
      category: 'Festa',
      status: 'rejected',
      hasReceipt: false,
      notes: 'Festa para conferência anual',
      location: 'Rio de Janeiro → São Paulo',
      paymentMethod: 'Cartão corporativo',
      approvedBy: '',
      approvedAt: '',
      userId: '1',
      isSynced: false,
      rejectionReason: null,
    ),
  ];
  // Simulate API call to get expenses
  Future<List<Expense>> getExpenses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockExpenses;
  }

  // Simulate API call to get a single expense
  Future<Expense> getExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final expense = _mockExpenses.firstWhere(
      (e) => e.id == id,
      orElse: () => throw Exception('Expense not found'),
    );
    return expense;
  }

  // Simulate API call to add an expense
  Future<Expense> addExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final newExpense = expense.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: 'pending',
    );
    _mockExpenses.add(newExpense);
    return newExpense;
  }

  // Simulate API call to update an expense
  Future<Expense> updateExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = _mockExpenses.indexWhere((e) => e.id == expense.id);
    if (index == -1) {
      throw Exception('Expense not found');
    }
    _mockExpenses[index] = expense;
    return expense;
  }

  // Simulate API call to delete an expense
  Future<void> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = _mockExpenses.indexWhere((e) => e.id == id);
    if (index == -1) {
      throw Exception('Expense not found');
    }
    _mockExpenses.removeAt(index);
  }
}
