import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';

class DioInterceptor extends Interceptor {
  final StorageService _storageService;
  final List<String> _publicRoutes = [
    '/login',
    '/auth/signin',
    '/auth/register',
    '/public-info',
  ];

  DioInterceptor(this._storageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isPublicRoute = _publicRoutes.contains(options.path);

    if (!isPublicRoute) {
      final token = await _storageService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        return handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 401,
              data: {'message': 'Unauthorized'},
            ),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      log("Invalid or Expired Token!");
      Modular.to.navigate("/");
    }
    handler.next(err);
  }
}
