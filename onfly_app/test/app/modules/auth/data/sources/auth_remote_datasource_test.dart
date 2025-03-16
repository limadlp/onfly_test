import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/modules/auth/data/models/auth_response_model.dart';
import 'package:onfly_app/app/modules/auth/data/sources/auth_remote_datasource.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockApiClient);
  });

  test('Should return a token when calling signin', () async {
    final mockResponse = AuthResponseModel(token: 'mock_token');
    when(
      () => mockApiClient.post(ApiUrl.signin, data: any(named: 'data')),
    ).thenAnswer((_) async => mockResponse.toMap());

    final result = await dataSource.signin('joao@email.com', '123456');

    expect(result.token, 'mock_token');
    verify(
      () => mockApiClient.post(ApiUrl.signin, data: any(named: 'data')),
    ).called(1);
  });

  test('Should throw an Exception if response has no token', () async {
    when(
      () => mockApiClient.post(ApiUrl.signin, data: any(named: 'data')),
    ).thenAnswer((_) async => {});

    expect(
      () => dataSource.signin('email@test.com', '123456'),
      throwsException,
    );
  });
}
