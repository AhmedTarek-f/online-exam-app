import 'package:flutter/material.dart';
import 'package:online_exam_app/core/common_widgets/custom_app_bar.dart';
import 'package:online_exam_app/core/constants/app_text.dart';

class SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignupAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(title: AppText.signup);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
