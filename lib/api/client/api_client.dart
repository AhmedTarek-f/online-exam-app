import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/email_verification_request/email_verification_request.dart';
import 'package:online_exam_app/api/requests/forget_password_request/forget_password_email_request.dart';
import 'package:online_exam_app/api/requests/login_request/login_request.dart';
import 'package:online_exam_app/api/requests/reset_password_request/reset_password_request.dart';
import 'package:online_exam_app/api/responses/email_verification_response/email_verification_response.dart';
import 'package:online_exam_app/api/responses/forget_password_response/forget_password_email_response.dart';
import 'package:online_exam_app/api/responses/login_response/login_response.dart';
import 'package:online_exam_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('/auth/signin')
  Future<LoginResponse> login({@Body() required LoginRequest request});

  @POST('/auth/forgotPassword')
  Future<ForgetPasswordEmailResponse> sendEmailVerification({
    @Body() required ForgetPasswordEmailRequest request,
  });

  @POST('/auth/verifyResetCode')
  Future<EmailVerificationResponse> verifyEmailCode({
    @Body() required EmailVerificationRequest request,
  });

  @PUT('/auth/resetPassword')
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest request,
  });
}
