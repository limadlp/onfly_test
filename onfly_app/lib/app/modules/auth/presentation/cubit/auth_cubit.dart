import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signin_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signout_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signup_usecase.dart';

import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SigninUsecase signinUsecase;
  final SignupUsecase signupUsecase;
  final SignoutUsecase signoutUsecase;

  AuthCubit({
    required this.signinUsecase,
    required this.signupUsecase,
    required this.signoutUsecase,
  }) : super(const AuthInitial());

  Future<void> signin(String email, String password) async {
    emit(const AuthLoading());

    final result = await signinUsecase(email: email, password: password);

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
        log(failure.message);
      },
      (token) {
        emit(const AuthSuccess());
      },
    );
  }

  Future<void> signup(String name, String email, String password) async {
    emit(const AuthLoading());

    final result = await signupUsecase(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(const AuthSuccess()),
    );
  }

  Future<void> signout() async {
    emit(const AuthLoading());

    final result = await signoutUsecase();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthInitial()),
    );
  }
}
