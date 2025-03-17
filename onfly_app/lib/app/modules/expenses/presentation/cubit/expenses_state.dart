import 'package:equatable/equatable.dart';
import 'package:onfly_app/app/modules/expenses/domain/entities/expense.dart';

abstract class ExpensesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  ExpensesLoaded(this.expenses);

  @override
  List<Object> get props => [expenses];
}

class ExpensesError extends ExpensesState {
  final String message;

  ExpensesError(this.message);

  @override
  List<Object> get props => [message];
}
