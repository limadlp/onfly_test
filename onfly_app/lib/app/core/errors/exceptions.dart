class ApiClientException implements Exception {
  final String message;
  final int? statusCode;

  ApiClientException(this.message, {this.statusCode});
}

class InvalidCredentialsException implements Exception {}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);
}
