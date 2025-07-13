import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/domain/use_cases/forget_password/send_email_verification_use_case.dart';
import 'package:online_exam_app/domain/use_cases/forget_password/verify_email_use_case.dart';
import 'package:online_exam_app/presentation/auth/forget_password/email_verification/views_model/email_verification_state.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';
import 'package:online_exam_app/utils/validations.dart';

@injectable
class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  @factoryMethod
  EmailVerificationCubit({
    required this.sendEmailVerificationUseCase,
    required this.verifyEmailUseCase,
  }) : super(EmailVerificationInitial());
  String? otpValidationValue;
  String otpValue = "";

  void onOtpValueChange({required String value}) {
    otpValue = value;
    if (otpValidationValue != null) {
      otpValidationValue = Validations.otpValidation(code: value);
      emit(OtpValidationErrorState());
    }
  }

  Future<void> continueToResetPassword() async {
    if (otpValue.isEmpty || otpValue.length < 6) {
      otpValidationValue = Validations.otpValidation(code: otpValue);
      emit(OtpValidationErrorState());
    } else {
      emit(OTPValidationLoadingState());
      if (isClosed) return;
      try {
        final String? status = await verifyEmailUseCase.invoke(code: otpValue);
        if (status?.toLowerCase() == ConstKeys.success) {
          emit(OTPValidationSuccessState());
        }
      } catch (error) {
        if (error is DioExceptions) {
          emit(
            OTPValidationFailureState(
              errorData:
                  error.responseException ??
                  ResponseException(code: 0, message: error.errorMessage),
            ),
          );
        }
      }
    }
  }

  Future<void> resendVerificationCode({required String userEmail}) async {
    emit(ResendCodeLoadingState());
    try {
      String? info = await sendEmailVerificationUseCase.invoke(
        email: userEmail,
      );

      emit(ResendCodeSuccessState(info: info));
    } catch (error) {
      if (error is DioExceptions) {
        emit(
          ResendCodeFailureState(
            errorData:
                error.responseException ??
                ResponseException(code: 0, message: error.errorMessage),
          ),
        );
      }
    }
  }
}
