import 'package:dio/dio.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/api/dio_interceptor.dart';
import 'package:onfly_app/app/core/constants/api_url.dart';
import 'package:onfly_app/app/core/storage/storage_service.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient(StorageService storageService)
    : _dio = Dio(
        BaseOptions(
          responseType: ResponseType.json,
          contentType: 'application/json',
          baseUrl: ApiUrl.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(DioInterceptor(storageService));
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  @override
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  @override
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  @override
  Future<dynamic> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  @override
  Future<dynamic> patch(String path, {dynamic data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'Erro desconhecido';
    }
    return 'Erro de conexão';
  }
}
