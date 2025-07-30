import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/data/data_source/forget_password/reset_password/remote_data_source/reset_password_remote_data_source.dart';
import 'package:online_exam_app/domain/repositories/forget_password/reset_password_repository.dart';

@Injectable(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource resetPasswordRemoteDataSource;
  @factoryMethod
  const ResetPasswordRepositoryImpl({
    required this.resetPasswordRemoteDataSource,
  });

  @override
  Future<Result<String?>> resetPassword({required ResetPasswordRequest request}) async {
    return await resetPasswordRemoteDataSource.resetPassword(request: request);
  }
}
