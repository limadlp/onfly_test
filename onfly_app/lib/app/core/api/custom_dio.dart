import 'package:dio/dio.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';

class CustomDio {
  static CustomDio? _simpleInstance;
  static CustomDio? _authInstance;

  late Dio _dio;

  BaseOptions options = BaseOptions(
    responseType: ResponseType.json,
    contentType: 'application/json',
    baseUrl: ApiUrl.baseUrl,
    connectTimeout: const Duration(milliseconds: 1000000),
    receiveTimeout: const Duration(milliseconds: 1000000),
  );
  CustomDio._() {
    _dio = Dio(options);
  }

  CustomDio._auth() {
    _dio = Dio(options);
    //_dio.interceptors.add(AuthInterceptor());
  }

  static Dio get instance {
    _simpleInstance ??= CustomDio._();
    return _simpleInstance!._dio;
  }

  static Dio get authInstance {
    _authInstance ??= CustomDio._auth();
    return _authInstance!._dio;
  }
}
