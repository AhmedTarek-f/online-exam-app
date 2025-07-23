import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/exam_score/views/widgets/exam_circle_progress_details.dart';
import 'package:online_exam_app/utils/dialogs/dialogs.dart';

class ExamScoreViewBody extends StatelessWidget {
  const ExamScoreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 22),
          Text(
            AppText.yourScore,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const RSizedBox(height: 24),
          const ExamCircleProgressDetails(),
          const RSizedBox(height: 80),
          CustomElevatedButton(
            onPressed: () {},
            buttonTitle: AppText.showResults,
          ),
          const RSizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {
              Dialogs.startQuiz(context: context, onStart: () {});
            },
            buttonTitle: AppText.startAgain,
            backgroundColor: Colors.transparent,
            borderColor: Theme.of(context).colorScheme.primary,
            titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
