import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';
import 'package:online_exam_app/data/data_source/forget_password/reset_password/remote_data_source/reset_password_remote_data_source.dart';

@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const ResetPasswordRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Result<String?>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return executeApi(() async {
      var response = await apiClient.resetPassword(
        request: ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return response.message;
    });
  }
}
