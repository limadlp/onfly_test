import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signin_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SigninUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SigninUsecase(mockRepository);
  });

  const testEmail = "test@email.com";
  const testPassword = "password123";
  const testToken = "valid_token";

  test("should return token when signin is successful", () async {
    when(
      () => mockRepository.signin(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => const Right(testToken));

    final result = await usecase(email: testEmail, password: testPassword);

    expect(result, equals(const Right(testToken)));
    verify(
      () => mockRepository.signin(email: testEmail, password: testPassword),
    ).called(1);
  });

  test("should return failure when signin fails", () async {
    when(
      () => mockRepository.signin(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => Left(ServerFailure("Signin failed")));

    final result = await usecase(email: testEmail, password: testPassword);

    expect(result, equals(Left(ServerFailure("Signin failed"))));
    verify(
      () => mockRepository.signin(email: testEmail, password: testPassword),
    ).called(1);
  });
}
