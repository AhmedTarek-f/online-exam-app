import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../core/router/route_names.dart';

@singleton
class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> logoutAndNavigateToLogin() async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      RouteNames.login,
          (route) => false,
    );
  }
}