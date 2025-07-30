import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';

abstract class SignupRepository {
  Future<UserDataEntity?> signup({required SignupRequest request});
}
