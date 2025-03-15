import 'package:onfly_app/app/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], token: json['token']);
  }
}
