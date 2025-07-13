import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/constants/app_images.dart';
import 'package:online_exam_app/core/constants/const_keys.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/utils/secure_storage/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterCheck();
  }

  Future<void> _navigateAfterCheck() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await SecureStorage.getData(key: ConstKeys.tokenKey);
    if (!mounted) return;
    final isLoggedIn = token != null && token.isNotEmpty;

    if (isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.dashboard,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(AppImages.appImage, height: 200.r, width: 200.r),
          ),
          const RSizedBox(height: 52),
          Center(
            child: SizedBox(
              width: 30.r,
              height: 30.r,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
