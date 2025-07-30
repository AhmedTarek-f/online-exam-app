import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';

abstract class LoginRemoteDataSource {
  Future<Result<UserDataEntity?>> login({required LoginRequest request});
}
