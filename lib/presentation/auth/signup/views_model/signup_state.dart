part of 'signup_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

final class EnableAutoValidateModeState extends SignUpState {}

final class ChangePasswordObscureState extends SignUpState {}

final class ChangeConfirmPasswordObscureState extends SignUpState {}

class SignUpFailure extends SignUpState {
  SignUpFailure({required this.errorData});
  final ResponseException errorData;
}
