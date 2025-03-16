import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/api/dio_api_client.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:onfly_app/app/modules/auth/presentation/pages/login_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);
    i.addSingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addSingleton<SigninUseCase>(SigninUseCase.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child:
          (context) => BlocProvider(
            create: (context) => AuthCubit(Modular.get<SigninUseCase>()),
            child: LoginPage(),
          ),
    );
  }
}
