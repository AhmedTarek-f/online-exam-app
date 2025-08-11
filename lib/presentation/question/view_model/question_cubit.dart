import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/question/remote_data_source/question_remote_data_source.dart';
import '../../../api/models/question_model.dart';
import '../../../core/constants/const_keys.dart';
import '../../../utils/secure_storage/secure_storage.dart';

part 'question_state.dart';

@lazySingleton
class QuestionCubit extends Cubit<QuestionState> {
  final QuestionRemoteDataSource questionRemoteDataSource;
  Timer? _questionTimer;

  bool isSubmitPressed = false;

  QuestionCubit(this.questionRemoteDataSource) : super(const QuestionInitial());

  Future<void> getQuestionList() async {
    emit(const QuestionLoading());

    try {
      final token = await SecureStorage.getData(key: ConstKeys.tokenKey);
      if (token == null) {
        emit(const QuestionError("Missing token"));
        return;
      }

      final questions = await questionRemoteDataSource.fetchQuestions(
          token, '6715e98c76fb2b224b2ffe2c');
      final totalDuration = getTotalDuration(questions);
      log("Total Exam Duration: $totalDuration seconds");

      emit(QuestionLoaded(
        questions: questions,
        selectedQuestionIndex: 0,
        selectedAnswers: {},
        remainingSeconds: 2,
        timerFinished: false,
      ));

      _startTimer();
    } catch (e, stackTrace) {
      emit(QuestionError("Failed to load questions: ${e.toString()}"));
      log(stackTrace.toString());
    }
  }

  void _startTimer() {
    _questionTimer?.cancel();

    if (state is! QuestionLoaded) return;

    final currentState = state as QuestionLoaded;
    int remaining = currentState.remainingSeconds;

    emit(currentState.copyWith(remainingSeconds: remaining));

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) return;

      final current = state;
      if (current is QuestionLoaded) {
        if (remaining <= 0) {
          // timer.cancel();
          emit(TimeOut(
            questions: current.questions,
            selectedAnswers: current.selectedAnswers,
          ));
          _questionTimer?.cancel();
        } else {
          remaining--;
          emit(current.copyWith(remainingSeconds: remaining));

        }
      }
    });
  }

  int getTotalDuration(List<QuestionModel> questions) {
    return questions.fold<int>(0, (sum, q) => sum + (q.exam?.duration ?? 0));
  }

  void _restartTimer() {
    _startTimer();
  }

  void nextQuestion() {
    final currentState = state;
    if (currentState is QuestionLoaded &&
        currentState.selectedQuestionIndex <
            currentState.questions.length - 1) {
      emit(currentState.copyWith(
        selectedQuestionIndex: currentState.selectedQuestionIndex + 1,
        timerFinished: false,
      ));
    }
  }

  void previousQuestion() {
    final currentState = state;
    if (currentState is QuestionLoaded &&
        currentState.selectedQuestionIndex > 0) {
      emit(currentState.copyWith(
        selectedQuestionIndex: currentState.selectedQuestionIndex - 1,
        timerFinished: false,
      ));
    }
  }

  void selectAnswer(int answerIndex) {
    if (state is QuestionLoaded) {
      final current = state as QuestionLoaded;
      final newAnswers = Map<int, int>.from(current.selectedAnswers);
      newAnswers[current.selectedQuestionIndex] = answerIndex;

      emit(current.copyWith(selectedAnswers: newAnswers));
    }
  }

  void submitExam() {
    if (state is QuestionLoaded && !isSubmitPressed) {
      isSubmitPressed = true;
      _questionTimer?.cancel();
      final current = state as QuestionLoaded;

      emit(QuestionSubmitted(
        questions: current.questions,
        selectedAnswers: current.selectedAnswers,
      ));
    }
  }

  bool isLastQuestion() {
    final current = state;
    if (current is QuestionLoaded) {
      return current.selectedQuestionIndex == current.questions.length - 1;
    }
    return false;
  }

  void clear() {
    _questionTimer?.cancel();
    isSubmitPressed = false;
    emit(const QuestionInitial());
  }

  @override
  Future<void> close() {
    _questionTimer?.cancel();
    return super.close();
  }
}
