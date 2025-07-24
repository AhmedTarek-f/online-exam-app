import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const LoginRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Result<UserLoginEntity?>> login({
    required String email,
    required String password,
  }) async {
    return executeApi(() async {
      var response = await apiClient.login(
        request: LoginRequest(email: email, password: password),
      );
      ExamMethodHelper.currentUserToken = response.token;
      await SecureStorage.saveData(
        key: ConstKeys.tokenKey,
        value: response.token ?? "",
      );
      var userData = response.userLoginData?.toUserLoginEntity();
      ExamMethodHelper.userData = userData;
      return userData;
    });
  }
}
