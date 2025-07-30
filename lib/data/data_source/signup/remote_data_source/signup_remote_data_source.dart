import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

abstract class SignupRemoteDataSource {
  Future<Result<UserDataEntity?>> signup({required SignupRequest request});
}
