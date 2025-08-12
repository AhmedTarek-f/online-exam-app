import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/api/models/question_model.dart';
import 'package:online_exam_app/presentation/question/answers_screen.dart';
import 'package:online_exam_app/presentation/question/question_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../core/common_widgets/custom_app_bar.dart';
import '../../core/common_widgets/custom_elevated_button.dart';
import '../../core/constants/app_text.dart';

class ExamScoreScreen extends StatelessWidget {
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers;

  const ExamScoreScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctCount = 0;

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final selectedIndex = selectedAnswers[i];

      if (selectedIndex != null) {
        final selectedAnswer = question.answers![selectedIndex];
        if (selectedAnswer.key == question.correct) {
          correctCount++;
        }
      }
    }

    final totalQuestions = questions.length;
    final incorrectCount = totalQuestions - correctCount;
    final scorePercent = correctCount / totalQuestions;
    final scoreText = (scorePercent * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: const CustomAppBar(title: AppText.examScore),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.yourScore,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            RSizedBox(height: 24.h),
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 65.r,
                  lineWidth: 10.0,
                  percent: scorePercent.clamp(0.0, 1.0),
                  center: Text("$scoreText%",
                      style: Theme.of(context).textTheme.titleLarge),
                  progressColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.red,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 500,
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScoreRow(context, AppText.correctWithSpaces, correctCount,
                          Theme.of(context).primaryColor),
                      SizedBox(height: 12.h),
                      _buildScoreRow(
                          context, AppText.incorrect, incorrectCount, Colors.red),
                    ],
                  ),
                ),
              ],
            ),
            RSizedBox(height: 60.h),
            CustomElevatedButton(
              buttonTitle: AppText.showResults,
              borderRadius: 24.r,
              titleStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AnswersScreen(
                    questions: questions,
                    selectedAnswers: selectedAnswers,
                  ),
                ),
              ),
            ),
            RSizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuestionScreen(),
                ),
              ),
              buttonTitle: AppText.startAgain,
              titleStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.sp,
              ),
              backgroundColor: Colors.transparent,
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 24.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(
    BuildContext context,
    String title,
    int count,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        RSizedBox(width: 50.w),
        Container(
          padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            "$count",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
