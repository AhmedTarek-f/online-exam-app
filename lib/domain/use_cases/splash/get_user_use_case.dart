import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/splash/splash_repository.dart';

@injectable
class GetUserUseCase {
  final SplashRepository _splashRepository;
  @factoryMethod
  const GetUserUseCase(this._splashRepository);

  Future<UserLoginEntity?> invoke() async {
    return await _splashRepository.getUserData();
  }
}
