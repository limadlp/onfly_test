import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/login_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SigninUseCase signinUseCase;

  AuthCubit(this.signinUseCase) : super(AuthInitial());

  Future<void> signin(String email, String password) async {
    emit(AuthLoading());
    try {
      await signinUseCase(email, password);
      emit(AuthSuccess());
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }
}
