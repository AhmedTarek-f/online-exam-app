import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/common_widgets/custom_text_form_field.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:online_exam_app/presentation/auth/login/views_model/login_state.dart';
import 'package:online_exam_app/utils/validations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          current is EnableAutoValidateModeState ||
          current is LoginLoadingState ||
          current is LoginFailureState,
      builder: (context, state) => Form(
        key: controller.loginFormKey,
        autovalidateMode: controller.autoValidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.emailController,
              label: AppText.email,
              hintText: AppText.emailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => Validations.emailValidation(email: value),
              enabled: state is! LoginLoadingState,
            ),
            const RSizedBox(height: 24),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => current is ChangeObscureState,
              builder: (context, __) => CustomTextFormField(
                controller: controller.passwordController,
                label: AppText.password,
                hintText: AppText.passwordHint,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.toggleObscure();
                  },
                  icon: Icon(
                    controller.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 22.r,
                  ),
                ),
                obscuringCharacter: "*",
                obscureText: controller.isObscure,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) =>
                    Validations.passwordValidation(password: value),
                enabled: state is! LoginLoadingState,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
