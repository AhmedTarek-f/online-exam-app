import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/data/data_source/signup/remote_data_source/signup_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: SignupRemoteDataSource)
class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final ApiClient _apiClient;
  const SignupRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserDataEntity?> signup({required SignupRequest request}) async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await _apiClient.signup(request: request);
        ExamMethodHelper.currentUserToken = response.token;
        await SecureStorage.saveUserToken(token: response.token);
        var userData = response.user?.toUserDataEntity();
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
