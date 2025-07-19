import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class SplashRepository {
  Future<UserLoginEntity?> getUserData();
}
