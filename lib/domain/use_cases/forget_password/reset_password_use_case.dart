import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/repositories/forget_password/reset_password_repository.dart';

@injectable
class ResetPasswordUseCase {
  final ResetPasswordRepository _resetPasswordRepository;
  @factoryMethod
  const ResetPasswordUseCase(this._resetPasswordRepository);

  Future<Result<String?>> invoke({
    required String email,
    required String newPassword,
  }) async {
    return await _resetPasswordRepository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
