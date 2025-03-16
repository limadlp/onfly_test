import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signin_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signout_usecase.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signup_usecase.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_cubit.dart';
import 'package:onfly_app/app/modules/auth/presentation/cubit/auth_state.dart';

class MockSigninUsecase extends Mock implements SigninUsecase {}

class MockSignupUsecase extends Mock implements SignupUsecase {}

class MockSignoutUsecase extends Mock implements SignoutUsecase {}

void main() {
  late AuthCubit authCubit;
  late MockSigninUsecase mockSigninUsecase;
  late MockSignupUsecase mockSignupUsecase;
  late MockSignoutUsecase mockSignoutUsecase;

  setUp(() {
    mockSigninUsecase = MockSigninUsecase();
    mockSignupUsecase = MockSignupUsecase();
    mockSignoutUsecase = MockSignoutUsecase();
    authCubit = AuthCubit(
      signinUsecase: mockSigninUsecase,
      signupUsecase: mockSignupUsecase,
      signoutUsecase: mockSignoutUsecase,
    );
  });
  tearDown(() {
    authCubit.close();
  });

  const testEmail = "test@email.com";
  const testPassword = "password123";
  const testName = "Test User";
  const testToken = "valid_token";

  group("signin", () {
    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthSuccess] when signin is successful",
      build: () {
        when(
          () => mockSigninUsecase(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => const Right(testToken));
        return authCubit;
      },
      act: (cubit) => cubit.signin(testEmail, testPassword),
      expect: () => [const AuthLoading(), const AuthSuccess()],
      verify: (_) {
        verify(
          () => mockSigninUsecase(email: testEmail, password: testPassword),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthError] when signin fails",
      build: () {
        when(
          () => mockSigninUsecase(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => Left(ServerFailure("Signin failed")));
        return authCubit;
      },
      act: (cubit) => cubit.signin(testEmail, testPassword),
      expect: () => [const AuthLoading(), const AuthError("Signin failed")],
      verify: (_) {
        verify(
          () => mockSigninUsecase(email: testEmail, password: testPassword),
        ).called(1);
      },
    );
  });

  group("signup", () {
    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthSuccess] when signup is successful",
      build: () {
        when(
          () => mockSignupUsecase(
            name: any(named: "name"),
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signup(testName, testEmail, testPassword),
      expect: () => [const AuthLoading(), const AuthSuccess()],
      verify: (_) {
        verify(
          () => mockSignupUsecase(
            name: testName,
            email: testEmail,
            password: testPassword,
          ),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthError] when signup fails",
      build: () {
        when(
          () => mockSignupUsecase(
            name: any(named: "name"),
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => Left(ServerFailure("Signup failed")));
        return authCubit;
      },
      act: (cubit) => cubit.signup(testName, testEmail, testPassword),
      expect: () => [const AuthLoading(), const AuthError("Signup failed")],
      verify: (_) {
        verify(
          () => mockSignupUsecase(
            name: testName,
            email: testEmail,
            password: testPassword,
          ),
        ).called(1);
      },
    );
  });

  group("signout", () {
    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthInitial] when signout is successful",
      build: () {
        when(
          () => mockSignoutUsecase(),
        ).thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signout(),
      expect: () => [const AuthLoading(), const AuthInitial()],
      verify: (_) {
        verify(() => mockSignoutUsecase()).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      "should emit [AuthLoading, AuthError] when signout fails",
      build: () {
        when(
          () => mockSignoutUsecase(),
        ).thenAnswer((_) async => Left(ServerFailure("Signout failed")));
        return authCubit;
      },
      act: (cubit) => cubit.signout(),
      expect: () => [const AuthLoading(), const AuthError("Signout failed")],
      verify: (_) {
        verify(() => mockSignoutUsecase()).called(1);
      },
    );
  });
}
