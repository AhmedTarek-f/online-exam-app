import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/splash/splash_repository.dart';

@Injectable(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource splashRemoteDataSource;
  @factoryMethod
  const SplashRepositoryImpl({required this.splashRemoteDataSource});

  @override
  Future<UserLoginEntity?> getUserData() async {
    return await splashRemoteDataSource.getUserData();
  }
}
