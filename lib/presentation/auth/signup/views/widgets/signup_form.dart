import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/api/requests/signup_request/signup_request.dart';
import 'package:online_exam_app/core/common_widgets/custom_text_form_field.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/presentation/auth/signup/views/widgets/signup_button.dart';
import 'package:online_exam_app/presentation/auth/signup/views_model/signup_cubit.dart';
import 'package:online_exam_app/utils/dimensions.dart';
import 'package:online_exam_app/utils/loaders/loaders.dart';
import 'package:online_exam_app/utils/validations.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _phoneController.dispose();
    _userNameFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SignUpCubit>(context);
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is SignUpFailure || current is SignUpSuccess,
      listener: (context, state) {
        if (state is SignUpFailure) {
          Loaders.showErrorMessage(
            message: state.errorData.message,
            context: context,
          );
        } else if (state is SignUpSuccess) {
          Navigator.of(context).pushReplacementNamed(RouteNames.dashboard);
        }
      },
      buildWhen: (previous, current) => current is EnableAutoValidateModeState,
      builder: (context, state) => Form(
        key: _formKey,
        autovalidateMode: controller.autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: _userNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              label: AppText.userName,
              hintText: AppText.userNameHint,
              validator: (value) => Validations.userNameValidation(name: value),
            ),
            const RSizedBox(height: Dimensions.paddingSizeLarge),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    label: AppText.firstName,
                    hintText: AppText.firstNameHint,
                    validator: (value) => Validations.validateEmptyText(value),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: CustomTextFormField(
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    label: AppText.lastName,
                    hintText: AppText.lastNameHint,
                    validator: (value) => Validations.validateEmptyText(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            CustomTextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              label: AppText.email,
              keyboardType: TextInputType.emailAddress,
              hintText: AppText.emailHint,
              validator: (value) => Validations.emailValidation(email: value),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        current is ChangePasswordObscureState,
                    builder: (context, __) => CustomTextFormField(
                      controller: _passwordController,
                      label: AppText.password,
                      hintText: AppText.passwordHint,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.togglePasswordObscure();
                        },
                        icon: Icon(
                          controller.isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: 22.r,
                        ),
                      ),
                      obscuringCharacter: "*",
                      obscureText: controller.isPasswordObscure,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          Validations.passwordValidation(password: value),
                      enabled: state is! SignUpLoading,
                    ),
                  ),
                ),
                const RSizedBox(width: Dimensions.paddingSizeLarge),
                Expanded(
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        current is ChangeConfirmPasswordObscureState,
                    builder: (context, __) => CustomTextFormField(
                      controller: _rePasswordController,
                      label: AppText.password,
                      hintText: AppText.passwordHint,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.toggleConfirmPasswordObscure();
                        },
                        icon: Icon(
                          controller.isConfirmPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: 22.r,
                        ),
                      ),
                      obscuringCharacter: "*",
                      obscureText: controller.isConfirmPasswordObscure,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          Validations.confirmPasswordValidation(
                            password: _passwordController.text,
                            conformPassword: value,
                          ),
                      enabled: state is! SignUpLoading,
                    ),
                  ),
                ),
              ],
            ),
            const RSizedBox(height: Dimensions.paddingSizeLarge),
            CustomTextFormField(
              controller: _phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              label: AppText.phoneNumber,
              hintText: AppText.phoneNumberHint,
              validator: (value) =>
                  Validations.phoneValidation(phoneNumber: value),
            ),
            const RSizedBox(height: Dimensions.paddingSizeExtraOverLarge),
            SignupButton(
              signupData: SignupRequest(
                username: _userNameController.text.trim(),
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text,
                rePassword: _rePasswordController.text,
                phone: _phoneController.text.trim(),
              ),
              signUpForm: _formKey,
            ),
            const RSizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppText.alreadyHaveAccount,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteNames.login),
                  child: Text(
                    AppText.login,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
