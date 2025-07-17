import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/use_cases/forget_password/send_email_verification_use_case.dart';
import 'package:online_exam_app/presentation/auth/forget_password/forget_password_email/views_model/forget_password_email_state.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';

@injectable
class ForgetPasswordEmailCubit extends Cubit<ForgetPasswordEmailState> {
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  @factoryMethod
  ForgetPasswordEmailCubit({required this.sendEmailVerificationUseCase})
    : super(ForgetPasswordEmailInitial()) {
    onInit();
  }
  late final TextEditingController emailController;
  late final GlobalKey<FormState> forgetPasswordFormKey;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void onInit() {
    forgetPasswordFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  Future<void> sendEmailValidation() async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      try {
        emit(SendEmailVerificationLoadingState());
        String? info = await sendEmailVerificationUseCase.invoke(
          email: emailController.text.trim(),
        );
        emit(SendEmailVerificationSuccessState(info: info));
      } catch (error) {
        if (error is DioExceptions) {
          emit(
            SendEmailVerificationFailureState(
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
    return super.close();
  }
}
