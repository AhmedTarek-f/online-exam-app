import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/utils/loaders/loaders.dart';
import 'package:online_exam_app/presentation/login/views/widgets/don_not_have_acc.dart';
import 'package:online_exam_app/presentation/login/views/widgets/login_button.dart';
import 'package:online_exam_app/presentation/login/views/widgets/login_form.dart';
import 'package:online_exam_app/presentation/login/views/widgets/remember_me_and_forget_pass_row.dart';
import 'package:online_exam_app/presentation/login/views_model/login_cubit.dart';
import 'package:online_exam_app/presentation/login/views_model/login_state.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          Loaders.showErrorMessage(
            message: state.errorData.message,
            context: context,
          );
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                current is LoginLoadingState || current is LoginFailureState,
            builder: (context, state) => AbsorbPointer(
              absorbing: state is LoginLoadingState,
              child: const Column(
                children: [
                  RSizedBox(height: 12),
                  LoginForm(),
                  RSizedBox(height: 15),
                  RememberMeAndForgetPassRow(),
                  RSizedBox(height: 63),
                  LoginButton(),
                  RSizedBox(height: 16),
                  DonNotHaveAcc(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
