import 'package:equatable/equatable.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

enum ExpensesStatus { initial, loading, loaded, error }

enum ExpenseFilter { all, pending, approved, rejected }

class ExpensesState extends Equatable {
  final List<Expense> expenses;
  final ExpensesStatus status;
  final String? errorMessage;
  final ExpenseFilter filter;
  final String searchQuery;
  final Map<String, double> expensesByCategory;

  const ExpensesState({
    this.expenses = const [],
    this.status = ExpensesStatus.initial,
    this.errorMessage,
    this.filter = ExpenseFilter.all,
    this.searchQuery = '',
    this.expensesByCategory = const {},
  });

  List<Expense> get filteredExpenses {
    return expenses.where((expense) {
      if (filter != ExpenseFilter.all) {
        switch (filter) {
          case ExpenseFilter.pending:
            if (expense.status != 'pending') return false;
            break;
          case ExpenseFilter.approved:
            if (expense.status != 'approved') return false;
            break;
          case ExpenseFilter.rejected:
            if (expense.status != 'rejected') return false;
            break;
          default:
            break;
        }
      }

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return expense.description.toLowerCase().contains(query) ||
            expense.category.toLowerCase().contains(query);
      }

      return true;
    }).toList();
  }

  double get totalAmount {
    return filteredExpenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  ExpensesState copyWith({
    List<Expense>? expenses,
    ExpensesStatus? status,
    String? errorMessage,
    ExpenseFilter? filter,
    String? searchQuery,
    Map<String, double>? expensesByCategory,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      status: status ?? this.status,
      errorMessage: errorMessage,
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
      expensesByCategory: expensesByCategory ?? this.expensesByCategory,
    );
  }

  @override
  List<Object?> get props => [
    expenses,
    status,
    errorMessage,
    filter,
    searchQuery,
    expensesByCategory,
  ];
}
