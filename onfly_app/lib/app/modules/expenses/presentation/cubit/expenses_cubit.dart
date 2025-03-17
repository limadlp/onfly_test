import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUsecase getExpensesUsecase;
  ExpensesCubit({required this.getExpensesUsecase}) : super(ExpensesLoading());
  Future<void> fetchExpenses() async {
    try {
      emit(ExpensesLoading());

      final result = await getExpensesUsecase.call();

      result.fold(
        (failure) {
          log(failure.message);
          emit(ExpensesError(failure.message));
        },
        (expenses) {
          emit(ExpensesLoaded(expenses));
        },
      );
    } catch (e) {
      emit(ExpensesError('Erro ao buscar despesas'));
    }
  }
}
