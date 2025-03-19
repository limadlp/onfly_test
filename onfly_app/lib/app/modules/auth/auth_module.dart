import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/core_module.dart';
import 'package:onfly_app/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_local_datasource.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signin_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signout_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signup_usecase.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:onfly_app/app/modules/auth/presentation/pages/login_page.dart';

// TODO: add signup page
class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);
    i.addSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl.new);
    i.addSingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addSingleton<SigninUsecase>(SigninUsecase.new);
    i.addSingleton<SignupUsecase>(SignupUsecase.new);
    i.addSingleton<SignoutUsecase>(SignoutUsecase.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child:
          (context) => BlocProvider(
            create:
                (context) => AuthCubit(
                  signinUsecase: Modular.get<SigninUsecase>(),
                  signupUsecase: Modular.get<SignupUsecase>(),
                  signoutUsecase: Modular.get<SignoutUsecase>(),
                ),
            child: const LoginPage(),
          ),
    );
  }
}
