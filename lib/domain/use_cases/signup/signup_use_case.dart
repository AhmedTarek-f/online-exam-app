import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/signup/signup_repository.dart';

@injectable
class SignupUseCase {
  final SignupRepository _signupRepository;
  @factoryMethod
  const SignupUseCase(this._signupRepository);

  Future<UserLoginEntity?> invoke({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    return await _signupRepository.signup(
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
