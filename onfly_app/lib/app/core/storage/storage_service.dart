import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class SharedPrefsStorageService implements StorageService {
  static const String _tokenKey = 'access_token';

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}


// With Flutter Secure Storage
// Only works on Android and IOS Platforms
// class FlutterSecureStorageService implements StorageService {
//   final FlutterSecureStorage storage = const FlutterSecureStorage();
//   String? _accessToken;

//   @override
//   Future<void> saveToken(String token) async {
//     _accessToken = token;
//     await storage.write(key: 'access_token', value: token);
//   }

//   @override
//   Future<String?> getToken() async {
//     if (_accessToken != null) return _accessToken;
//     _accessToken = await storage.read(key: 'access_token');
//     return _accessToken;
//   }

//   @override
//   Future<void> clearToken() async {
//     _accessToken = null;
//     await storage.delete(key: 'access_token');
//   }
// }