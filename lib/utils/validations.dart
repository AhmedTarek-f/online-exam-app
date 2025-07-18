import 'package:online_exam_app/core/constants/app_text.dart';

abstract class Validations {
  static String? userNameValidation({required String? name}) {
    if ((name?.isEmpty ?? true) || name?.trim() == "") {
      return AppText.userNameValidation;
    }
    return null;
  }

  static String? validateEmptyText(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.emptyTextValidation;
    }
    return null;
  }

  static String? phoneValidation({required String? phoneNumber}) {
    if (phoneNumber?.trim() == "" ||
        (phoneNumber?.isEmpty ?? true) ||
        phoneNumber == null) {
      return AppText.phoneNumberValidation;
    } else if (phoneNumber.length < 11) {
      return AppText.phoneNumberValidation2;
    }
    return null;
  }

  static String? emailValidation({required String? email}) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email?.trim() == "" || (email?.isEmpty ?? true) || email == null) {
      return AppText.emailValidation;
    } else if (!emailRegex.hasMatch(email)) {
      return AppText.emailValidation2;
    }
    return null;
  }

  static String? passwordValidation({required String? password}) {
    if ((password?.isEmpty ?? true) ||
        password?.trim() == "" ||
        password == null) {
      return AppText.passwordValidation;
    } else if (password.length < 8) {
      return AppText.passwordValidation2;
    } else if (RegExp(r'\s').hasMatch(password)) {
      return AppText.passwordValidation3;
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return AppText.passwordValidation4;
    } else if (password.length > 20) {
      return AppText.passwordValidation5;
    }
    return null;
  }

  static String? confirmPasswordValidation({
    required String? conformPassword,
    required String? password,
  }) {
    if ((conformPassword?.isEmpty ?? true) ||
        conformPassword?.trim() == "" ||
        conformPassword == null) {
      return AppText.confirmPasswordValidation;
    } else if (conformPassword != password) {
      return AppText.confirmPasswordValidation2;
    } else if (RegExp(r'\s').hasMatch(conformPassword)) {
      return AppText.passwordValidation3;
    }
    return null;
  }

  static String? otpValidation({required String? code}) {
    if ((code?.isEmpty ?? true) || code?.trim() == "" || code == null) {
      return AppText.otpValidation;
    } else if (code.length < 6) {
      return AppText.otpValidation2;
    }
    return null;
  }
}
