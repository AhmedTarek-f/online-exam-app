import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';
import 'package:online_exam_app/domain/repositories/login/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  @factoryMethod
  const LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<UserDataEntity?> login({required LoginRequest request}) async {
    return await loginRemoteDataSource.login(request: request);
  }
}
