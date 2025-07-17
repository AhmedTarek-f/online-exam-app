import 'package:flutter/material.dart';
import 'package:online_exam_app/core/common_widgets/custom_app_bar.dart';
import 'package:online_exam_app/core/constants/app_text.dart';

class ExamScoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExamScoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: AppText.examScore,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
