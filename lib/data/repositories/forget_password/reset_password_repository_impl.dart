import 'package:injectable/injectable.dart';
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
  Future<String?> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return await resetPasswordRemoteDataSource.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
