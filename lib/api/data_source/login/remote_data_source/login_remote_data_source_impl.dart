import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/core/utils/exam_method_helper.dart';
import 'package:online_exam_app/core/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/core/utils/secure_storage/secure_storage.dart';
import 'package:online_exam_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const LoginRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<UserLoginEntity?> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiClient.login(
        request: LoginRequest(email: email, password: password),
      );
      ExamMethodHelper.currentUserToken = response.token;
      await SecureStorage.saveData(
        key: ConstKeys.tokenKey,
        value: response.token ?? "",
      );
      return response.userLoginData?.toUserLoginEntity();
    } catch (error) {
      throw DioExceptions.handleError(error);
    }
  }
}
