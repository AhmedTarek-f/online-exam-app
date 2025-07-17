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
    return Row(
      children: [
        CircularPercentIndicator(
          radius: 66.r,
          lineWidth: 8.w,
          animation: true,
          percent: controller.percentageDecimal,
          center: Text(
            controller.percentage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Theme.of(context).primaryColor,
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    SmallCircleText(
                      text: controller.examScoreData.correctAnswers.toString(),
                      borderColor: Theme.of(context).colorScheme.primary,
                      textStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(
                            color: Theme.of(context).colorScheme.primary,
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    SmallCircleText(
                      text: controller.examScoreData.inCorrectAnswers
                          .toString(),
                      borderColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      textStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
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
