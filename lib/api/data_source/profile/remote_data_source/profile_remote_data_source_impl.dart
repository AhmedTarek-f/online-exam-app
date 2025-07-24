import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<void>> logout() async {
    return executeApi(() async {
      await apiClient.logout(token: ExamMethodHelper.currentUserToken ?? "");
      await SecureStorage.deleteData(key: ConstKeys.tokenKey);
      ExamMethodHelper.userData = null;
    });
  }
}
