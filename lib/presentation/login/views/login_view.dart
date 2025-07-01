import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/login/views/widgets/login_app_bar.dart';
import 'package:online_exam_app/presentation/login/views/widgets/login_view_body.dart';
import 'package:online_exam_app/presentation/login/views_model/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => getIt.get<LoginCubit>(),
      child: const Scaffold(appBar: LoginAppBar(), body: LoginViewBody()),
    );
  }
}
