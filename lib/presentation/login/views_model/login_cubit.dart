import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/presentation/login/views_model/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
}
