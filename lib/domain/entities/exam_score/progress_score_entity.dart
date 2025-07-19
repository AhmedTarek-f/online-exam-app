import 'package:equatable/equatable.dart';

class ProgressScoreEntity extends Equatable {
  const ProgressScoreEntity({
    required this.correctAnswers,
    required this.inCorrectAnswers,
    required this.questionsNumber,
  });
  final int correctAnswers;
  final int inCorrectAnswers;
  final int questionsNumber;

  @override
  List<Object?> get props => [
    correctAnswers,
    inCorrectAnswers,
    questionsNumber,
  ];
}
