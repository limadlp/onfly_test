import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_service.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUsecase getExpensesUsecase;
  //TODO: Remove service, change to usecase
  final ExpenseService _expenseService = ExpenseService();
  ExpensesCubit({required this.getExpensesUsecase})
    : super(const ExpensesState()) {
    loadExpenses();
  }

  // Future<void> fetchExpenses() async {
  //   try {
  //     emit(ExpensesLoading());

  //     final result = await getExpensesUsecase.call();
  //     result.fold(
  //       (failure) {
  //         log(failure.message);
  //         emit(ExpensesError(failure.message));
  //       },
  //       (expenses) {
  //         final expensesByCategory = _calculateExpensesByCategory(expenses);
  //         emit(
  //           ExpensesLoaded(
  //             expenses: expenses,
  //             expensesByCategory: expensesByCategory,
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     emit(ExpensesError('Erro ao buscar despesas'));
  //   }
  // }

  Future<void> loadExpenses() async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    try {
      final expenses = await _expenseService.getExpenses();
      final expensesByCategory = _calculateExpensesByCategory(expenses);
      emit(
        state.copyWith(
          expenses: expenses,
          status: ExpensesStatus.loaded,
          expensesByCategory: expensesByCategory,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpensesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<Expense> getExpense(String id) async {
    try {
      return await _expenseService.getExpense(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void setFilter(ExpenseFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> addExpense(Expense expense) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    try {
      final newExpense = await _expenseService.addExpense(expense);
      final updatedExpenses = [...state.expenses, newExpense];
      final expensesByCategory = _calculateExpensesByCategory(updatedExpenses);
      emit(
        state.copyWith(
          expenses: updatedExpenses,
          status: ExpensesStatus.loaded,
          expensesByCategory: expensesByCategory,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpensesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateExpense(Expense expense) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    try {
      final updatedExpense = await _expenseService.updateExpense(expense);
      final updatedExpenses =
          state.expenses.map((e) {
            return e.id == updatedExpense.id ? updatedExpense : e;
          }).toList();
      final expensesByCategory = _calculateExpensesByCategory(updatedExpenses);
      emit(
        state.copyWith(
          expenses: updatedExpenses,
          status: ExpensesStatus.loaded,
          expensesByCategory: expensesByCategory,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpensesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteExpense(String id) async {
    emit(state.copyWith(status: ExpensesStatus.loading));
    try {
      await _expenseService.deleteExpense(id);
      final updatedExpenses = state.expenses.where((e) => e.id != id).toList();
      final expensesByCategory = _calculateExpensesByCategory(updatedExpenses);
      emit(
        state.copyWith(
          expenses: updatedExpenses,
          status: ExpensesStatus.loaded,
          expensesByCategory: expensesByCategory,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ExpensesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Map<String, double> _calculateExpensesByCategory(List<Expense> expenses) {
    final result = <String, double>{};
    for (final expense in expenses) {
      result[expense.category] =
          (result[expense.category] ?? 0) + expense.amount;
    }
    return result;
  }
}
