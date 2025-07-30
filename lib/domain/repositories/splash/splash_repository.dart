import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/domain/entities/login/user_data_entity.dart';

abstract class SplashRepository {
  Future<Result<UserDataEntity?>> getUserData();
}
