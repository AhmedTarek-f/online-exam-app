import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_cubit.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_intent.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) =>
          getIt.get<SplashCubit>()..doIntent(intent: GetUserDataIntent()),
      child: const Scaffold(body: SplashViewBody()),
    );
  }
}
