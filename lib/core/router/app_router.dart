import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/presentation/auth/forget_password/email_verification/views/email_verification_view.dart';
import 'package:online_exam_app/presentation/auth/forget_password/forget_password_email/views/forget_password_email_view.dart';
import 'package:online_exam_app/presentation/auth/forget_password/reset_password/views/reset_password_view.dart';
import 'package:online_exam_app/presentation/auth/login/views/login_view.dart';
import 'package:online_exam_app/presentation/auth/signup/views/sign_up_screen.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/screens/profile_screen.dart';
import 'package:online_exam_app/presentation/splash/presentation/views/splash_screen.dart';

import '../../presentation/dashboard/presentation/cubits/home_cubit.dart';
import '../../presentation/dashboard/presentation/cubits/nav_bar_cuibts/nav_bar_cubit.dart';
import '../../presentation/dashboard/presentation/screens/home_screen.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteNames.resetPassword:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordView(userEmail: email),
        );
      case RouteNames.dashboard:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getIt<NavBarCubit>(),
                  child: DashboardScreen(),
                ));
      case RouteNames.homeView:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getIt<HomeCubit>(),
                  child: const HomeScreen(),
                ));
      case RouteNames.profileView:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getIt<HomeCubit>(),
                  child: const ProfileScreen(),
                ));

      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
    return null;
  }
}
