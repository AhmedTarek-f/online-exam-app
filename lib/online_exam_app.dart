import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/app_theme.dart';
import 'package:online_exam_app/core/router/app_router.dart';
import 'package:online_exam_app/core/router/route_names.dart';

class OnlineExamApp extends StatelessWidget {
  const OnlineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Online Exam',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.lightTheme,
        themeMode: ThemeMode.dark,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouteNames.login,
      ),
    );
  }
}
