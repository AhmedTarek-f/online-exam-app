import 'package:online_exam_app/utils/exceptions/response_exception.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutLoadingState extends ProfileState {}

final class LogoutFailureState extends ProfileState {
  LogoutFailureState({required this.errorData});
  final ResponseException errorData;
}
