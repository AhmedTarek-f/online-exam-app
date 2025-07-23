import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/repositories/profile/profile_repository.dart';

@injectable
class LogoutUseCase {
  final ProfileRepository _profileRepository;
  @factoryMethod
  const LogoutUseCase(this._profileRepository);

  Future<void> invoke() async {
    return await _profileRepository.logout();
  }
}
