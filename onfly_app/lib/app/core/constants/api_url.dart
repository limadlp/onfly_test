import 'dart:io';

class ApiUrl {
  static String get baseUrl {
    const apiPort = '5000';

    if (Platform.isAndroid) {
      return 'http://10.0.2.2:$apiPort'; // Android Emulator
    } else if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
      return 'http://127.0.0.1:$apiPort'; // iOS Simulator, Mac, Linux
    } else if (Platform.isWindows) {
      return 'http://127.0.0.1:$apiPort'; // Windows
    } else {
      return 'http://192.168.1.X:$apiPort'; // Physical devices (replace with network IP)
    }
  }

  static const String signin = '/auth/signin';
  static const String signup = '/auth/signup';
  static const String expenses = '/expenses';

  static String get signinUrl => '$baseUrl$signin';
  static String get signupUrl => '$baseUrl$signup';
  static String get expensesUrl => '$baseUrl$expenses';
}
