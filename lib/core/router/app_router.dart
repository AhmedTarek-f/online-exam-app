import 'package:flutter/material.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/presentation/login/views/login_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());

      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
    return null;
  }
}
