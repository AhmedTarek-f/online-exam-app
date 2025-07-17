import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/api/models/login/user_login_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "userLoginData")
  final UserModel? userLoginData;

  LoginResponse({this.message, this.token, this.userLoginData});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
}
