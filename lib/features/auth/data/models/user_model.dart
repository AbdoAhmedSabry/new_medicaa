import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.phone,
    super.photoURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      photoURL: json['photoURL'],
    );
  }
  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.name,
      phone: user.phone,
      photoURL: user.photoURL,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'photoURL': photoURL,
    };
  }
}
