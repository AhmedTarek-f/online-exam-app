import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/cache/shared_preferences_helper.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/my_bloc_observer.dart';
import 'package:online_exam_app/online_exam_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await ScreenUtil.ensureScreenSize();
  await SharedPreferencesHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  FlutterNativeSplash.remove();
  runApp(const OnlineExamApp());
}
