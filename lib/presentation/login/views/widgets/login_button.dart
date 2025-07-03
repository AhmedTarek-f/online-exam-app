import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
import 'package:online_exam_app/core/common_widgets/loading_button.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/login/views_model/login_cubit.dart';
import 'package:online_exam_app/presentation/login/views_model/login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          current is LoginLoadingState ||
          current is LoginFailureState ||
          current is LoginSuccessState,
      builder: (context, state) => state is LoginLoadingState
          ? const LoadingButton()
          : CustomElevatedButton(
              onPressed: () async => await controller.login(),
              buttonTitle: AppText.login,
            ),
    );
  }
}
