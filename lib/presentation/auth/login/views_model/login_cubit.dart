import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/cache/shared_preferences_helper.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:online_exam_app/presentation/auth/login/views_model/login_state.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  @factoryMethod
  LoginCubit({required this.loginWithEmailAndPasswordUseCase})
    : super(LoginInitial()) {
    onInit();
  }

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> loginFormKey;
  late bool rememberMe;
  bool isObscure = true;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void onInit() async {
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    getRememberMeValue();
    if (rememberMe) await getRememberedUserData();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void toggleObscure() {
    isObscure = !isObscure;
    emit(ChangeObscureState());
  }

  void getRememberMeValue() {
    rememberMe = SharedPreferencesHelper.getBool(key: ConstKeys.rememberMe);
  }

  Future<void> toggleRememberMe() async {
    rememberMe = !rememberMe;
    await SharedPreferencesHelper.saveBool(
      key: ConstKeys.rememberMe,
      value: rememberMe,
    );
    await forgetUserData();
    emit(ToggleRememberMeState());
  }

  Future<void> rememberUserData() async {
    await SecureStorage.saveData(
      key: ConstKeys.email,
      value: emailController.text,
    );
    await SecureStorage.saveData(
      key: ConstKeys.password,
      value: passwordController.text,
    );
  }

  Future<void> forgetUserData() async {
    await SecureStorage.deleteData(key: ConstKeys.email);
    await SecureStorage.deleteData(key: ConstKeys.password);
  }

  Future<void> getRememberedUserData() async {
    emailController.text =
        await SecureStorage.getData(key: ConstKeys.email) ?? "";
    passwordController.text =
        await SecureStorage.getData(key: ConstKeys.password) ?? "";
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        emit(LoginLoadingState());
        UserLoginEntity? userData = await loginWithEmailAndPasswordUseCase
            .invoke(
              email: emailController.text,
              password: passwordController.text,
            );
        ExamMethodHelper.userData = userData;
        if (rememberMe) await rememberUserData();
        emit(LoginSuccessState());
      } catch (error) {
        if (error is DioExceptions) {
          emit(
            LoginFailureState(
              errorData:
                  error.responseException ??
                  ResponseException(code: 0, message: error.errorMessage),
            ),
          );
        }
      }
    } else {
      enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
