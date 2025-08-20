import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> logout() async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        await apiClient.logout(token: ExamMethodHelper.currentUserToken ?? "");
        await SecureStorage.deleteData(key: ConstKeys.tokenKey);
        ExamMethodHelper.userData = null;
      } else {
        throw AppText.connectionValidation;
      }
    } catch (error) {
      throw DioExceptions.handleError(error);
    }
  }
}
