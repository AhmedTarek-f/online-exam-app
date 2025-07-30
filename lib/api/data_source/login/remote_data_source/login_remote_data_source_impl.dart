import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient _apiClient;
  const LoginRemoteDataSourceImpl(this._apiClient);
  @override
  Future<UserDataEntity?> login({required LoginRequest request}) async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await _apiClient.login(request: request);
        ExamMethodHelper.currentUserToken = response.token;
        await SecureStorage.saveUserToken(token: response.token);
        var userData = response.userLoginData?.toUserDataEntity();
        ExamMethodHelper.userData = userData;
        return userData;
      } else {
        throw AppText.connectionValidation;
      }
    } catch (error) {
      throw DioExceptions.handleError(error);
    }
  }
}
