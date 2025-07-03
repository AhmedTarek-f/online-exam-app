import 'package:flutter/material.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/presentation/forget_password/email_verification/views/email_verification_view.dart';
import 'package:online_exam_app/presentation/forget_password/forget_password_email/views/forget_password_email_view.dart';
import 'package:online_exam_app/presentation/forget_password/reset_password/views/reset_password_view.dart';
import 'package:online_exam_app/presentation/login/views/login_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.forgetPasswordEmail:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordEmailView(),
        );
      case RouteNames.emailVerification:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EmailVerificationView(userEmail: email),
        );
      case RouteNames.resetPassword:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordView(userEmail: email),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
    return null;
  }
}
