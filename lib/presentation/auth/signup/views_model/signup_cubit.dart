import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_result.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';
import 'package:online_exam_app/domain/use_cases/signup/signup_use_case.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';

part 'signup_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignupUseCase signupUseCase;
  @factoryMethod
  SignUpCubit(this.signupUseCase) : super(SignUpInitial());

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(ChangePasswordObscureState());
  }

  void toggleConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(ChangeConfirmPasswordObscureState());
  }

  Future<void> signUp({
    required SignupRequest signupData,
    required GlobalKey<FormState> signUpForm,
  }) async {
    if (signUpForm.currentState!.validate()) {
      emit(SignUpLoading());
      var result = await signupUseCase.invoke(
        request: SignupRequest(
          username: signupData.username!,
          firstName: signupData.firstName!,
          lastName: signupData.lastName!,
          email: signupData.email!,
          password: signupData.password!,
          rePassword: signupData.rePassword!,
          phone: signupData.phone!,
        ),
      );
      switch (result) {
        case Success<UserLoginEntity?>():
          emit(SignUpSuccess());
          break;
        case Failure<UserLoginEntity?>():
          emit(
            SignUpFailure(
              errorData:
                  result.responseException ??
                  ResponseException(code: 0, message: result.errorMessage),
            ),
          );
          break;
      }
    } else {
      enableAutoValidateMode();
    }
  }
}
