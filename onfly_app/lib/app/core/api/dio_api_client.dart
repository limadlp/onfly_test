import 'package:dio/dio.dart';
import 'package:onfly_app/app/core/api/api_client.dart';
import 'package:onfly_app/app/core/errors/exceptions.dart';
import 'package:onfly_app/app/core/api/dio_interceptors.dart';
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
    _dio.interceptors.addAll([
      DioInterceptor(storageService),
      //LoggerInterceptor(),
    ]);
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _handleRequest(
      () => _dio.get(url, queryParameters: queryParameters),
    );
  }

  @override
  Future<dynamic> post(String url, {dynamic data}) async {
    return _handleRequest(() => _dio.post(url, data: data));
  }

  @override
  Future<dynamic> put(String url, {dynamic data}) async {
    return _handleRequest(() => _dio.put(url, data: data));
  }

  @override
  Future<dynamic> delete(String url, {dynamic data}) async {
    return _handleRequest(() => _dio.delete(url, data: data));
  }

  @override
  Future<dynamic> patch(String url, {dynamic data}) async {
    return _handleRequest(() => _dio.patch(url, data: data));
  }

  Future<dynamic> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw ApiClientException(
        e.response?.data['message'] ?? 'Unknown API error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiClientException('Unexpected error: ${e.toString()}');
    }
  }
}
