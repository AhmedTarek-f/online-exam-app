import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/api/requests/email_verification_request/email_verification_request.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/data/data_source/forget_password/email_verification/remote_data_source/email_verification_remote_data_source.dart';
import 'package:online_exam_app/utils/connection_manager/connection_manager.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';

@Injectable(as: EmailVerificationRemoteDataSource)
class EmailVerificationRemoteDataSourceImpl
    implements EmailVerificationRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  const EmailVerificationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String?> verifyEmailCode({required String code}) async {
    try {
      final bool connection = await ConnectionManager.checkConnection();
      if (connection) {
        var response = await apiClient.verifyEmailCode(
          request: EmailVerificationRequest(resetCode: code),
        );
        return response.status;
      } else {
        throw AppText.connectionValidation;
      }
    } catch (error) {
      throw DioExceptions.handleError(error);
    }
  }
}
