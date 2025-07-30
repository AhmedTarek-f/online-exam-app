import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/domain/use_cases/signup/signup_use_case.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
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
      try {
        emit(SignUpLoading());
        await signupUseCase.invoke(
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
        emit(SignUpSuccess());
      } catch (error) {
        if (error is DioExceptions) {
          emit(
            SignUpFailure(
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
}
