import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class LoginRemoteDataSource {
  Future<UserLoginEntity?> login({
    required String email,
    required String password,
  });
}
