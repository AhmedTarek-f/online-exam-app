import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class LoginRemoteDataSource {
  Future<Result<UserDataEntity?>> login({required LoginRequest request});
}
