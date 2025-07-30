import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<String?> resetPassword({required ResetPasswordRequest request});
}
