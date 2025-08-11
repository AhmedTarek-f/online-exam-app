part of 'question_cubit.dart';

abstract class QuestionState {
  const QuestionState();
}

class QuestionInitial extends QuestionState {
  const QuestionInitial();
}

class QuestionLoading extends QuestionState {
  const QuestionLoading();
}

class QuestionError extends QuestionState {
  final String message;

  const QuestionError(this.message);
}

class QuestionLoaded extends QuestionState {
  final List<QuestionModel> questions;
  final int selectedQuestionIndex;
  final Map<int, int> selectedAnswers;
  final int remainingSeconds;
  final bool timerFinished;

  const QuestionLoaded({
    required this.questions,
    required this.selectedQuestionIndex,
    required this.selectedAnswers,
    this.remainingSeconds = 0,
    this.timerFinished = false,
  });

  QuestionModel get currentQuestion => questions[selectedQuestionIndex];

  QuestionLoaded copyWith({
    List<QuestionModel>? questions,
    int? selectedQuestionIndex,
    Map<int, int>? selectedAnswers,
    int? remainingSeconds,
    bool? timerFinished,
  }) {
    return QuestionLoaded(
      questions: questions ?? this.questions,
      selectedQuestionIndex:
          selectedQuestionIndex ?? this.selectedQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      timerFinished: timerFinished ?? this.timerFinished,
    );
  }
}

class QuestionSubmitted extends QuestionState {
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers;

  const QuestionSubmitted({
    required this.questions,
    required this.selectedAnswers,
  });
}

class TimeOut extends QuestionState {
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers;

  const TimeOut({
    required this.questions,
    required this.selectedAnswers,
  });
}
