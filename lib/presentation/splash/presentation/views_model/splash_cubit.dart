import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/domain/use_cases/splash/get_user_use_case.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_intent.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_state.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetUserUseCase _getUserUseCase;
  SplashCubit(this._getUserUseCase) : super(SplashInitial());

  Future<void> doIntent({required SplashIntent intent}) async {
    switch (intent) {
      case GetUserDataIntent():
        await _navigateAfterCheck();
        break;
      case NavigateToLoginViewIntent():
        await _navigateToLogin();
        break;
    }
  }

  Future<void> _getUserData() async {
    try {
      emit(FetchUserDataLoadingState());
      var userData = await _getUserUseCase.invoke();
      ExamMethodHelper.userData = userData;
      emit(FetchUserDataSuccessState());
    } catch (error) {
      if (error is DioExceptions) {
        emit(
          FetchUserDataFailureState(
            errorData:
                error.responseException ??
                ResponseException(code: 0, message: error.errorMessage),
          ),
        );
      }
    }
  }

  Future<void> _navigateAfterCheck() async {
    final token = await SecureStorage.getData(key: ConstKeys.tokenKey);
    ExamMethodHelper.currentUserToken = token;
    final isLoggedIn = token != null && token.isNotEmpty;
    if (isLoggedIn) {
      await _getUserData();
    } else {
      emit(NavigationState());
    }
  }

  Future<void> _navigateToLogin() async {
    await SecureStorage.deleteData(key: ConstKeys.tokenKey);
    ExamMethodHelper.currentUserToken = null;
    ExamMethodHelper.userData = null;
    emit(NavigationState());
  }
}
