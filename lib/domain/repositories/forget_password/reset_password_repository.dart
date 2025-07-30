import 'package:online_exam_app/api/client/api_result.dart';

abstract class ResetPasswordRepository {
  Future<Result<String?>> resetPassword({
    required String email,
    required String newPassword,
  });
}
