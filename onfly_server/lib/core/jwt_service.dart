import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtService {
  static const String _secretKey = 'my_secret_key';

  static String generateToken(String email) {
    final claimSet = JwtClaim(
      issuer: 'api.local',
      subject: email,
      expiry: DateTime.now().add(Duration(minutes: 30)),
    );
    return issueJwtHS256(claimSet, _secretKey);
  }
}
