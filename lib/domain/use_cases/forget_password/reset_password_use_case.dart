import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/repositories/forget_password/reset_password_repository.dart';

@injectable
class ResetPasswordUseCase {
  final ResetPasswordRepository _resetPasswordRepository;
  @factoryMethod
  const ResetPasswordUseCase(this._resetPasswordRepository);

  Future<Result<String?>> invoke({required ResetPasswordRequest request}) async {
    return await _resetPasswordRepository.resetPassword(request: request);
  }
}
