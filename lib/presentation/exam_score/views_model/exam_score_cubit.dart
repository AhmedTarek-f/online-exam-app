import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entities/exam_score/progress_score_entity.dart';
import 'package:online_exam_app/presentation/exam_score/views_model/exam_score_intent.dart';
import 'package:online_exam_app/presentation/exam_score/views_model/exam_score_state.dart';

@injectable
class ExamScoreCubit extends Cubit<ExamScoreState> {
  @factoryMethod
  ExamScoreCubit() : super(ExamScoreInitial());
  late ProgressScoreEntity examScoreData;
  late double percentageDecimal;
  late String percentage;

  void doIntent(ExamScoreIntent intent) {
    switch (intent) {
      case FetchInitialDataIntent():
        _onInit();
        break;
      case ShowExamResultIntent():
        break;
      case StartAgainIntent():
        break;
    }
  }

  void _onInit() {
    examScoreData = const ProgressScoreEntity(
      correctAnswers: 18,
      inCorrectAnswers: 2,
      questionsNumber: 20,
    );
    _calculateScorePercentage();
  }

  void _calculateScorePercentage() {
    percentageDecimal =
        examScoreData.correctAnswers / examScoreData.questionsNumber;
    percentage = "${(percentageDecimal * 100).toStringAsFixed(0)}%";
  }
}
