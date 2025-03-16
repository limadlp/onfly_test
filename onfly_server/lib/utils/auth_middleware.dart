import 'package:onfly_api/utils/jwt_service.dart';
import 'package:shelf/shelf.dart';

Middleware authenticateRequests() {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.forbidden(
          '{"error": "Missing or invalid token"}',
          headers: {'Content-Type': 'application/json'},
        );
      }

      final token = authHeader.substring(7); // Remove 'Bearer ' prefix
      final email = JwtService.verifyTokenAndGetEmail(token);

      if (email == null) {
        return Response.forbidden(
          '{"error": "Invalid or expired token"}',
          headers: {'Content-Type': 'application/json'},
        );
      }

      // Pass the email to the request context
      final updatedRequest = request.change(context: {'email': email});
      return innerHandler(updatedRequest);
    };
  };
}
