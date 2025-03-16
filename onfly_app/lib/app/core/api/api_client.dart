abstract class ApiClient {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {dynamic data});
  Future<dynamic> put(String path, {dynamic data});
  Future<dynamic> delete(String path, {dynamic data});
  Future<dynamic> patch(String path, {dynamic data});
}
