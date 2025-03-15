import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtService {
  static const String _secretKey = 'my_secret_key';

  static String generateToken(String email) {
    final claimSet = JwtClaim(
      issuer: 'api.local',
      subject: email,
      expiry: DateTime.now().add(
        Duration(hours: 2),
      ), // Token expires in 2 hours
    );
    return issueJwtHS256(claimSet, _secretKey);
  }

  static String? verifyTokenAndGetEmail(String token) {
    try {
      final claimSet = verifyJwtHS256Signature(token, _secretKey);

      // Check if the token has expired
      if (claimSet.expiry != null &&
          claimSet.expiry!.isBefore(DateTime.now())) {
        return null; // Token expired
      }

      return claimSet.subject; // Extract email from token
    } catch (e) {
      return null; // Invalid token
    }
  }
}
