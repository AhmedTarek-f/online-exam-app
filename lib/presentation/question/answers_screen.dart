import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/models/question_model.dart';
import '../../core/common_widgets/custom_app_bar.dart';

class AnswersScreen extends StatelessWidget {
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers;

  const AnswersScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Answers",
        isBackButtonExist: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (_, index) {
          final question = questions[index];
          final selectedIndex = selectedAnswers[index];
          final correctKey = question.correct;
          final answers = question.answers ?? [];

          return Container(
            padding: REdgeInsets.all(16.r),
            margin: REdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${question.question}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                ...List.generate(answers.length, (index) {
                  final isSelected = selectedIndex == index;
                  final isCorrect = answers[index].key == correctKey;
                  final unSelectedAnswer = answers[index].answer ?? '';

                  Color bgColor =
                      Theme.of(context).primaryColor.withValues(alpha: 0.065);
                  Color textColor = Colors.black;

                  if (isCorrect) {
                    bgColor = Colors.green.shade100;
                    textColor = Colors.green;
                  }

                  if (isSelected && !isCorrect) {
                    bgColor = Colors.red.shade100;
                    textColor = Colors.red;
                  }

                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: (_) {},
                          visualDensity: VisualDensity.comfortable,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: isSelected
                              ? (isCorrect ? Colors.green : Colors.red)
                              : !isSelected
                                  ? (isCorrect ? Colors.green : Colors.red)
                                  : Colors.transparent,
                        ),
                        RSizedBox(
                          width: 4.w,
                        ),
                        Flexible(
                          child: Text(
                            answers[index].answer ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
