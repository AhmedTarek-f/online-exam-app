import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class SplashRemoteDataSource {
  Future<UserLoginEntity?> getUserData();
}
