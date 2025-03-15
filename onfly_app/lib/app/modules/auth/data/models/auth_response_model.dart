import 'dart:convert';

class AuthResponseModel {
  final String token;

  AuthResponseModel({required this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'token': token};
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(token: (map['token'] ?? '') as String);
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
