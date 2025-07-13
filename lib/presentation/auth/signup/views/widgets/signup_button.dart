import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/auth/signup/views_model/signup_cubit.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.signupData,
    required this.signUpForm,
  });
  final SignupRequest signupData;
  final GlobalKey<FormState> signUpForm;
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SignUpCubit>(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) => CustomElevatedButton(
        buttonTitle: state is SignUpLoading
            ? AppText.signupDots
            : AppText.signup,
        onPressed: state is SignUpLoading
            ? () {}
            : () async {
                await controller.signUp(
                  signupData: signupData,
                  signUpForm: signUpForm,
                );
              },
      ),
    );
  }
}
