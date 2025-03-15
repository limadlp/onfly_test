import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/modules/auth/data/models/auth_response_model.dart';
import 'package:onfly_app/app/modules/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signin(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<AuthResponseModel> signin(String email, String password) async {
    final response = await apiClient.post(
      ApiUrl.signin,
      data: {'email': email, 'password': password},
    );
    if (response is Map<String, dynamic> && response.containsKey('token')) {
      return AuthResponseModel.fromMap(response);
    } else {
      throw Exception('Invalid API response: $response');
    }
  }
}
