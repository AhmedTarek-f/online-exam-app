import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:online_exam_app/domain/repositories/profile/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  @factoryMethod
  const ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<void> logout() async {
    await profileRemoteDataSource.logout();
  }
}
