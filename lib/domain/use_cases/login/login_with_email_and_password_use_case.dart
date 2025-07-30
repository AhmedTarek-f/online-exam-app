import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/domain/repositories/login/login_repository.dart';

@injectable
class LoginWithEmailAndPasswordUseCase {
  final LoginRepository _loginRepository;
  @factoryMethod
  const LoginWithEmailAndPasswordUseCase(this._loginRepository);

  Future<UserDataEntity?> invoke({required LoginRequest request}) async {
    return await _loginRepository.login(request: request);
  }
}
