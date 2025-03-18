import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/errors/failures.dart';
import 'package:onfly_app/app/modules/auth/data/models/user_model.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockApiClient);
  });

  const String testEmail = "test@email.com";
  const String testPassword = "password123";
  const String testName = "Test User";
  const String testToken = "valid_token";
  const String testUserId = "1";

  group("signin", () {
    test("should return token when API call is successful", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenAnswer((_) async => {"token": testToken});

      final result = await dataSource.signin(
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(const Right<String, String>(testToken)));
      verify(
        () => mockApiClient.post(ApiUrl.signinUrl, data: any(named: "data")),
      ).called(1);
    });

    test("should return InvalidCredentialsFailure on 401 response", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenThrow(ApiClientException("Unauthorized", statusCode: 401));

      final result = await dataSource.signin(
        email: testEmail,
        password: testPassword,
      );

      expect(
        result,
        equals(Left<Failure, String>(InvalidCredentialsFailure())),
      );
    });

    test("should return ServerFailure on unexpected errors", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenThrow(Exception("Unexpected error"));

      final result = await dataSource.signin(
        email: testEmail,
        password: testPassword,
      );

      expect(result, isA<Left<Failure, String>>());
    });
  });

  group("signup", () {
    final testUser = UserModel(
      id: testUserId,
      name: testName,
      email: testEmail,
      token: testToken,
    );

    test("should return UserModel when API call is successful", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenAnswer(
        (_) async => {
          "id": testUserId,
          "name": testName,
          "email": testEmail,
          "token": testToken,
        },
      );

      final result = await dataSource.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(Right<Failure, UserModel>(testUser)));
    });

    test("should return ServerFailure on 400 response", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenThrow(ApiClientException("Bad Request", statusCode: 400));

      final result = await dataSource.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(
        result,
        equals(Left<Failure, UserModel>(ServerFailure("Bad Request"))),
      );
    });

    test("should return ServerFailure on unexpected errors", () async {
      when(
        () => mockApiClient.post(any(), data: any(named: "data")),
      ).thenThrow(Exception("Unexpected error"));

      final result = await dataSource.signup(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result, isA<Left<Failure, UserModel>>());
    });
  });
}
