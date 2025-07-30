import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/login/login_repository.dart';

@injectable
class LoginWithEmailAndPasswordUseCase {
  final LoginRepository _loginRepository;
  @factoryMethod
  const LoginWithEmailAndPasswordUseCase(this._loginRepository);

  Future<Result<UserLoginEntity?>> invoke({
    required String email,
    required String password,
  }) async {
    return await _loginRepository.login(email: email, password: password);
  }
}
