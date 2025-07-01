// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../api/client/api_client.dart' as _i508;
import '../../api/client/api_module.dart' as _i272;
import '../../api/data_source/login/remote_data_source/login_remote_data_source_impl.dart'
    as _i221;
import '../../data/data_source/login/remote_data_source/login_remote_data_source.dart'
    as _i684;
import '../../data/repositories/login_repository_impl.dart' as _i919;
import '../../domain/repositories/login_repository.dart' as _i703;
import '../../domain/use_cases/login/login_with_email_and_password_use_case.dart'
    as _i197;
import '../../presentation/login/views_model/login_cubit.dart' as _i521;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.singleton<_i361.Dio>(() => apiModule.provideDio());
    gh.factory<_i508.ApiClient>(() => _i508.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i684.LoginRemoteDataSource>(
      () => _i221.LoginRemoteDataSourceImpl(apiClient: gh<_i508.ApiClient>()),
    );
    gh.factory<_i703.LoginRepository>(
      () => _i919.LoginRepositoryImpl(
        loginRemoteDataSource: gh<_i684.LoginRemoteDataSource>(),
      ),
    );
    gh.factory<_i197.LoginWithEmailAndPasswordUseCase>(
      () => _i197.LoginWithEmailAndPasswordUseCase(gh<_i703.LoginRepository>()),
    );
    gh.factory<_i521.LoginCubit>(
      () => _i521.LoginCubit(
        loginWithEmailAndPasswordUseCase:
            gh<_i197.LoginWithEmailAndPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i272.ApiModule {}
