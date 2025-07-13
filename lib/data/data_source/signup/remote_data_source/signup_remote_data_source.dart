import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class SignupRemoteDataSource {
  Future<UserLoginEntity?> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });
}
