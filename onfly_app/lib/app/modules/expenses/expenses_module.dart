import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/modules/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_drift_datasource.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_remote_datasource.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/add_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/delete_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/update_expense_usecase.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/upload_receipt_usecase.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/expenses_page.dart';

class ExpensesModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    // Local DB
    i.addSingleton<ExpensesDriftDatabase>(ExpensesDriftDatabase.new);

    // Remote datasource
    i.addSingleton<ExpensesRemoteDatasource>(ExpensesRemoteDatasourceImpl.new);

    // Repository
    i.addSingleton<ExpensesRepository>(ExpensesRepositoryImpl.new);

    // Usecases
    i.addSingleton<GetExpensesUsecase>(GetExpensesUsecase.new);
    i.addSingleton<GetExpenseUsecase>(GetExpenseUsecase.new);
    i.addSingleton<AddExpenseUsecase>(AddExpenseUsecase.new);
    i.addSingleton<UpdateExpenseUsecase>(UpdateExpenseUsecase.new);
    i.addSingleton<DeleteExpenseUsecase>(DeleteExpenseUsecase.new);
    i.addSingleton<UploadReceiptUsecase>(UploadReceiptUsecase.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child:
          (context) => BlocProvider(
            create:
                (context) => ExpensesCubit(
                  getExpensesUsecase: Modular.get<GetExpensesUsecase>(),
                  getExpenseUsecase: Modular.get<GetExpenseUsecase>(),
                  addExpenseUsecase: Modular.get<AddExpenseUsecase>(),
                  updateExpenseUsecase: Modular.get<UpdateExpenseUsecase>(),
                  deleteExpenseUsecase: Modular.get<DeleteExpenseUsecase>(),
                  uploadReceiptUsecase: Modular.get<UploadReceiptUsecase>(),
                ),
            child: const ExpensesPage(),
          ),
    );
  }
}
