import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/modules/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:onfly_app/app/modules/expenses/data/sources/expenses_remote_datasource.dart';
import 'package:onfly_app/app/modules/expenses/domain/repositories/expenses_repository.dart';
import 'package:onfly_app/app/modules/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:onfly_app/app/modules/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:onfly_app/app/modules/expenses/presentation/pages/expenses_page.dart';

class ExpensesModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<ExpensesRemoteDatasource>(ExpensesRemoteDatasourceImpl.new);
    i.addSingleton<ExpensesRepository>(ExpensesRepositoryImpl.new);
    i.addSingleton<GetExpensesUsecase>(GetExpensesUsecase.new);
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
                ),
            child: const ExpensesPage(),
          ),
    );
  }
}
