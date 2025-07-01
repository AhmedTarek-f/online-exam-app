import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  @factoryMethod
  const LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<UserLoginEntity?> login({
    required String email,
    required String password,
  }) async {
    return await loginRemoteDataSource.login(email: email, password: password);
  }
}
