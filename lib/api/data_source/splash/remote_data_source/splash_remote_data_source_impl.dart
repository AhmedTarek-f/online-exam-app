import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';

@Injectable(as: SplashRemoteDataSource)
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const SplashRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserLoginEntity?> getUserData() async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await apiClient.getUserData(
          token: ExamMethodHelper.currentUserToken ?? "",
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
