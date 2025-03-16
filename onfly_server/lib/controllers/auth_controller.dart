import 'dart:convert';
import 'package:onfly_api/utils/json_response.dart';
import 'package:shelf/shelf.dart';
import 'package:onfly_api/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<Response> signUp(Request request) async {
    final payload = jsonDecode(await request.readAsString());
    final user = await _authService.signUp(
      payload['name'],
      payload['email'],
      payload['password'],
    );

    if (user == null) {
      return Response.forbidden(jsonEncode({'error': 'User already exists'}));
    }

    return jsonResponse({'message': 'User created successfully'});
  }

  Future<Response> signIn(Request request) async {
    final payload = jsonDecode(await request.readAsString());
    final token = await _authService.signIn(
      payload['email'],
      payload['password'],
    );

    if (token == null) {
      return Response.forbidden(jsonEncode({'error': 'Invalid credentials'}));
    }

    return jsonResponse({'token': token});
  }
}
