import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';

import 'package:online_exam_app/api/client/api_result.dart';

abstract class ResetPasswordRepository {
  Future<Result<String?>> resetPassword({required ResetPasswordRequest request});
}
