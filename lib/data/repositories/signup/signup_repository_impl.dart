import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/data/data_source/signup/remote_data_source/signup_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/signup/signup_repository.dart';

@Injectable(as: SignupRepository)
class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource signupRemoteDataSource;
  @factoryMethod
  const SignupRepositoryImpl({required this.signupRemoteDataSource});

  @override
  Future<Result<UserLoginEntity?>> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    return await signupRemoteDataSource.signup(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}
