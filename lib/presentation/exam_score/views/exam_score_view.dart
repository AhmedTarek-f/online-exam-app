import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/exam_score/views/widgets/exam_score_app_bar.dart';
import 'package:online_exam_app/presentation/exam_score/views/widgets/exam_score_view_body.dart';
import 'package:online_exam_app/presentation/exam_score/views_model/exam_score_cubit.dart';
import 'package:online_exam_app/presentation/exam_score/views_model/exam_score_intent.dart';

class ExamScoreView extends StatelessWidget {
  const ExamScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExamScoreCubit>(
      create: (context) =>
          getIt.get<ExamScoreCubit>()..doIntent(FetchInitialDataIntent()),
      child: const Scaffold(
        appBar: ExamScoreAppBar(),
        body: ExamScoreViewBody(),
      ),
    );
  }
}
