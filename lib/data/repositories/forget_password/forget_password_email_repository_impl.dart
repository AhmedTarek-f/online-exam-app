import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/forget_password/forget_password_email/remote_data_source/forget_password_email_remote_data_source.dart';
import 'package:online_exam_app/domain/repositories/forget_password/forget_password_email_repository.dart';

@Injectable(as: ForgetPasswordEmailRepository)
class ForgetPasswordEmailRepositoryImpl
    implements ForgetPasswordEmailRepository {
  final ForgetPasswordEmailRemoteDataSource forgetPasswordEmailRemoteDataSource;
  @factoryMethod
  const ForgetPasswordEmailRepositoryImpl({
    required this.forgetPasswordEmailRemoteDataSource,
  });
  @override
  Future<String?> sendEmailVerification({required String email}) async {
    return await forgetPasswordEmailRemoteDataSource.sendEmailVerification(
      email: email,
    );
  }
}
