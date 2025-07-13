import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/auth/signup/views/widgets/signup_app_bar.dart';
import 'package:online_exam_app/presentation/auth/signup/views/widgets/signup_form.dart';
import 'package:online_exam_app/presentation/auth/signup/views_model/signup_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: Scaffold(
        appBar: const SignupAppBar(),
        body: SingleChildScrollView(
          padding: REdgeInsets.all(16),
          child: const SignupForm(),
        ),
      ),
    );
  }
}
