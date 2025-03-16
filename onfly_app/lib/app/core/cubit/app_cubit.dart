import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/core/cubit/auth_state.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthCubit authCubit;

  AppCubit(this.authCubit) : super(AppInitial()) {
    authCubit.stream.listen((authState) {
      if (authState is AuthSuccess) {
        emit(AppAuthenticated());
      } else if (authState is AuthError || authState is AuthInitial) {
        emit(AppUnauthenticated());
      }
    });
  }

  void logout() async {
    await authCubit.signout();
  }
}
