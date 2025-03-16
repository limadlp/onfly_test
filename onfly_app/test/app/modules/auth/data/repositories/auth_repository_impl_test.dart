import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/data/models/user_model.dart';
import 'package:onfly_app/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_local_datasource.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';
import 'package:onfly_app/app/modules/auth/domain/entities/user_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const String testEmail = "test@email.com";
  const String testPassword = "password123";
  const String testName = "Test User";
  const String testToken = "valid_token";
  const String testUserId = "1";

  group("signin", () {
    test("should return token when signin is successful", () async {
      when(
        () => mockRemoteDataSource.signin(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => const Right(testToken));

      when(() => mockLocalDataSource.saveToken(any())).thenAnswer((_) async {});

      final result = await repository.signin(
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(const Right(testToken)));
      verify(
        () => mockRemoteDataSource.signin(
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);
      verify(() => mockLocalDataSource.saveToken(testToken)).called(1);
    });

    test("should return failure when signin fails", () async {
      when(
        () => mockRemoteDataSource.signin(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => Left(ServerFailure("Server error")));

      final result = await repository.signin(
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(Left(ServerFailure("Server error"))));
      verify(
        () => mockRemoteDataSource.signin(
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);
      verifyNever(
        () => mockLocalDataSource.saveToken(any()),
      ); // Should not save token on failure
    });
  });

  group("signup", () {
    final testUser = UserModel(
      id: testUserId,
      name: testName,
      email: testEmail,
      token: testToken,
    );

    test("should return UserEntity when signup is successful", () async {
      when(
        () => mockRemoteDataSource.signup(
          name: any(named: "name"),
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => Right(testUser));

      when(() => mockLocalDataSource.saveToken(any())).thenAnswer((_) async {});

      final result = await repository.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(Right<UserEntity, UserEntity>(testUser)));
      verify(
        () => mockRemoteDataSource.signup(
          name: testName,
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);
      verify(() => mockLocalDataSource.saveToken(testUser.token!)).called(1);
    });

    test("should return failure when signup fails", () async {
      when(
        () => mockRemoteDataSource.signup(
          name: any(named: "name"),
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => Left(ServerFailure("Signup error")));

      final result = await repository.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(Left(ServerFailure("Signup error"))));
      verify(
        () => mockRemoteDataSource.signup(
          name: testName,
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);
      verifyNever(
        () => mockLocalDataSource.saveToken(any()),
      ); // Should not save token on failure
    });
  });

  group("signout", () {
    test("should clear token when signout is successful", () async {
      when(() => mockLocalDataSource.clearToken()).thenAnswer((_) async {});

      final result = await repository.signout();

      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.clearToken()).called(1);
    });

    test("should return failure when signout fails", () async {
      when(
        () => mockLocalDataSource.clearToken(),
      ).thenThrow(Exception("Storage error"));

      final result = await repository.signout();

      expect(result, isA<Left<Failure, void>>());
      verify(() => mockLocalDataSource.clearToken()).called(1);
    });
  });
}
