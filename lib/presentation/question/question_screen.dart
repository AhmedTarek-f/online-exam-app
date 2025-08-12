import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_exam_app/core/common_widgets/custom_app_bar.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/presentation/question/exam_score_screen.dart';
import 'package:online_exam_app/presentation/question/view_model/question_cubit.dart';
import 'package:online_exam_app/presentation/question/widgets/custom_dialog_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/di.dart';
import '../../core/constants/app_icons.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final QuestionCubit _questionCubit;

  @override
  void initState() {
    super.initState();
    _questionCubit = getIt<QuestionCubit>();
    _questionCubit.getQuestionList();
  }

  @override
  void dispose() {
    _questionCubit.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionCubit>.value(
      value: _questionCubit,
      child: BlocConsumer<QuestionCubit, QuestionState>(
        listener: (context, state) {
          if (state is QuestionSubmitted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ExamScoreScreen(
                  questions: state.questions,
                  selectedAnswers: state.selectedAnswers,
                ),
              ),
            );
          }
          /*else if (state is QuestionLoaded) {
              if (state.timerFinished && !_questionCubit.isSubmitPressed) {
                // _questionCubit.isSubmitPressed = true;

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => CustomDialogWidget(
                    buttonTitle: AppText.viewScore,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExamScoreScreen(
                            questions: state.questions,
                            selectedAnswers: state.selectedAnswers,
                          ),
                        ),
                      );
                    },
                    icon: AppIcons.sandWatchIcon,
                  ),
                );
              }
            }*/
          else if (state is TimeOut) {
            /* showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => CustomDialogWidget(
                      buttonTitle: AppText.viewScore,
                      onPressed: () {
                        _questionCubit.submitExam();
                      },
                      icon: AppIcons.sandWatchIcon,
                    ));*/

            Dialogs.customDialog(
              context: context,
              content: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.sandWatchIcon,
                    height: 130.h,
                    width: 130.w,
                  ),
              Text(
                    "Time's out !!",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                        Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExamScoreScreen(
                          questions: state.questions,
                          selectedAnswers: state.selectedAnswers,
                        ),
                      ),
                    );
                  },
                  buttonTitle: AppText.viewScore,
                ),
              ],
            );
          }
        },
        builder: (context, state) {
          if (state is QuestionLoading || state is QuestionInitial) {
            return PopScope(
              onPopInvokedWithResult: (_, __) async {
                context.read<QuestionCubit>().clear();
              },
              canPop: true,
              child: const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (state is QuestionLoaded) {
            final currentQuestion = state.currentQuestion;
            final totalQuestions = state.questions.length;
            final currentIndex = state.selectedQuestionIndex;
            final selectedIndex = state.selectedAnswers[currentIndex];

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: const CustomAppBar(
                title: AppText.exam,
                showTimer: true,
                isBackButtonExist: true,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${AppText.question} ${currentIndex + 1} of $totalQuestions',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.gray),
                    ),
                    SizedBox(height: 12.h),
                    LinearPercentIndicator(
                      percent: (currentIndex + 1) / totalQuestions,
                      barRadius: const Radius.circular(24),
                      progressColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      currentQuestion.question ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentQuestion.answers?.length ?? 0,
                        itemBuilder: (context, index) {
                          final answer = currentQuestion.answers![index];
                          final isSelected = selectedIndex == index;
                          Color textColor = Colors.black;
                          Color bgColor = Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.055);

                          if (isSelected) {
                            bgColor = Theme.of(context)
                                .primaryColor
                                .withValues(alpha: 0.2);
                            textColor = Theme.of(context).primaryColor;
                          }
                          return GestureDetector(
                            onTap: () {
                              context.read<QuestionCubit>().selectAnswer(index);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: index,
                                    groupValue: selectedIndex,
                                    onChanged: (_) {
                                      context
                                          .read<QuestionCubit>()
                                          .selectAnswer(index);
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      answer.answer ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: currentIndex == 0
                                ? () {}
                                : () => context
                                    .read<QuestionCubit>()
                                    .previousQuestion(),
                            isText: true,
                            buttonTitle: AppText.back,
                            titleStyle: Theme.of(context).textTheme.labelMedium,
                            borderRadius: 10.r,
                            backgroundColor: Colors.transparent,
                            borderColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: selectedIndex == null
                                ? null
                                : () {
                                    if (currentIndex == totalQuestions - 1) {
                                      context
                                          .read<QuestionCubit>()
                                          .submitExam();
                                    } else {
                                      context
                                          .read<QuestionCubit>()
                                          .nextQuestion();
                                    }
                                  },
                            isText: true,
                            buttonTitle: currentIndex == totalQuestions - 1
                                ? AppText.submit
                                : AppText.next,
                            borderRadius: 10.r,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is QuestionError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
