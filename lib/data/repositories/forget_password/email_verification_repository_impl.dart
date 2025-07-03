import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/forget_password/email_verification/remote_data_source/email_verification_remote_data_source.dart';
import 'package:online_exam_app/domain/repositories/forget_password/email_verification_repository.dart';

@Injectable(as: EmailVerificationRepository)
class EmailVerificationRepositoryImpl implements EmailVerificationRepository {
  final EmailVerificationRemoteDataSource emailVerificationRemoteDataSource;
  @factoryMethod
  const EmailVerificationRepositoryImpl({
    required this.emailVerificationRemoteDataSource,
  });

  @override
  Future<String?> verifyEmail({required String code}) async {
    return await emailVerificationRemoteDataSource.verifyEmailCode(code: code);
  }
}
