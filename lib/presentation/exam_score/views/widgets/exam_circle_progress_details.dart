import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/exam_score/views/widgets/small_circle_text.dart';
import 'package:online_exam_app/presentation/exam_score/views_model/exam_score_cubit.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class ExamCircleProgressDetails extends StatelessWidget {
  const ExamCircleProgressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ExamScoreCubit>(context);
    final theme = Theme.of(context);
    return Row(
      children: [
        CircularPercentIndicator(
          radius: 66.r,
          lineWidth: 8.w,
          animation: true,
          percent: controller.percentageDecimal,
          center: Text(
            controller.percentage,
            style: theme.textTheme.titleLarge,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: theme.colorScheme.primary,
        ),
        const RSizedBox(width: 23),
        Expanded(
          child: Padding(
            padding: REdgeInsetsDirectional.only(end: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppText.correct,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    SmallCircleText(
                      text: controller.examScoreData.correctAnswers.toString(),
                      borderColor: theme.colorScheme.primary,
                      textStyle: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const RSizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppText.inCorrect,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    SmallCircleText(
                      text: controller.examScoreData.inCorrectAnswers
                          .toString(),
                      borderColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      textStyle: theme.textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
