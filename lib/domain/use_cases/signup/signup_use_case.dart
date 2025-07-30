import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/domain/repositories/signup/signup_repository.dart';

@injectable
class SignupUseCase {
  final SignupRepository _signupRepository;
  @factoryMethod
  const SignupUseCase(this._signupRepository);

  Future<Result<UserDataEntity?>> invoke({required SignupRequest request}) async {
    return await _signupRepository.signup(request: request);
  }
}
