import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/data/data_source/signup/remote_data_source/signup_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: SignupRemoteDataSource)
class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const SignupRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserLoginEntity?> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await apiClient.signup(
          request: SignupRequest(
            email: email,
            password: password,
            phone: phone,
            lastName: lastName,
            firstName: firstName,
            rePassword: rePassword,
            username: username,
          ),
        );
        ExamMethodHelper.currentUserToken = response.token;
        await SecureStorage.saveData(
          key: ConstKeys.tokenKey,
          value: response.token ?? "",
        );
        var userData = response.user?.toUserLoginEntity();
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

// Future<UserLoginEntity?> signup({
//   required String email,
//   required String password,
// }) async {
//   try {
//     final bool connection = await ConnectionManager.checkConnection();
//     if (connection) {
//       var response = await apiClient.login(
//         request: LoginRequest(email: email, password: password),
//       );
//       ExamMethodHelper.currentUserToken = response.token;
//       await SecureStorage.saveData(
//         key: ConstKeys.tokenKey,
//         value: response.token ?? "",
//       );
//       var userData = response.userLoginData?.toUserLoginEntity();
//       ExamMethodHelper.userData = userData;
//       return userData;
//     } else {
//       throw AppText.connectionValidation;
//     }
//   } catch (error) {
//     throw DioExceptions.handleError(error);
//   }
// }
