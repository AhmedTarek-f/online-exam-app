import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "isVerified")
  final bool? isVerified;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserLoginModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return _$UserLoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserLoginModelToJson(this);
  }

  UserLoginEntity toUserLoginEntity() {
    return UserLoginEntity(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
