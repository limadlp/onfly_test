import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/domain/entities/user.dart';
import 'package:onfly_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:onfly_app/app/modules/auth/domain/usecases/signup_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignupUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignupUsecase(mockRepository);
  });

  const testName = "Test User";
  const testEmail = "test@email.com";
  const testPassword = "password123";
  final testUser = User(
    id: "1",
    name: testName,
    email: testEmail,
    token: "valid_token",
  );

  test("should return User when signup is successful", () async {
    when(
      () => mockRepository.signup(
        name: any(named: "name"),
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => Right(testUser));

    final result = await usecase(
      name: testName,
      email: testEmail,
      password: testPassword,
    );

    expect(result, equals(Right(testUser)));
    verify(
      () => mockRepository.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      ),
    ).called(1);
  });

  test("should return failure when signup fails", () async {
    when(
      () => mockRepository.signup(
        name: any(named: "name"),
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => Left(ServerFailure("Signup failed")));

    final result = await usecase(
      name: testName,
      email: testEmail,
      password: testPassword,
    );

    expect(result, equals(Left(ServerFailure("Signup failed"))));
    verify(
      () => mockRepository.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      ),
    ).called(1);
  });
}
