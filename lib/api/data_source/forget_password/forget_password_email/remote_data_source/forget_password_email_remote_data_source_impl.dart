import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/forget_password_request/forget_password_email_request.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';

import '../../../../../data/data_source/forget_password/forget_password_email/remote_data_source/forget_password_email_remote_data_source.dart';

@Injectable(as: ForgetPasswordEmailRemoteDataSource)
class ForgetPasswordEmailRemoteDataSourceImpl
    implements ForgetPasswordEmailRemoteDataSource {
  final ApiClient _apiClient;
  const ForgetPasswordEmailRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String?> sendEmailVerification({required String email}) async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await _apiClient.sendEmailVerification(
          request: ForgetPasswordEmailRequest(email: email),
        );
        return response.info;
      } else {
        throw AppText.connectionValidation;
      }
    } catch (error) {
      throw DioExceptions.handleError(error);
    }
  }
}
