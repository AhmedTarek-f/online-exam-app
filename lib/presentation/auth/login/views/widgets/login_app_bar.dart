import 'package:flutter/material.dart';
import 'package:online_exam_app/core/common_widgets/custom_app_bar.dart';
import 'package:online_exam_app/core/constants/app_text.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(title: AppText.login);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
