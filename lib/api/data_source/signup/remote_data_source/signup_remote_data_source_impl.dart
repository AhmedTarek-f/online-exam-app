import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/data/data_source/signup/remote_data_source/signup_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: SignupRemoteDataSource)
class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final ApiClient _apiClient;
  const SignupRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<UserDataEntity?>> signup({
    required SignupRequest request,
  }) async {
    return executeApi(() async {
      var response = await _apiClient.signup(request: request);
      ExamMethodHelper.currentUserToken = response.token;
      await SecureStorage.saveUserToken(token: response.token);
      var userData = response.user?.toUserDataEntity();
      ExamMethodHelper.userData = userData;
      return userData;
    });
  }
}
