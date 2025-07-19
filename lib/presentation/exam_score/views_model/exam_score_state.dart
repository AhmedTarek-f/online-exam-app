import 'package:equatable/equatable.dart';

sealed class ExamScoreState extends Equatable {}

final class ExamScoreInitial extends ExamScoreState {
  @override
  List<Object?> get props => [];
}

/*
*
final class ExamScoreInitial extends ExamScoreState {
  ExamScoreInitial({
    this.examScoreData,
    this.percentageDecimal,
    this.percentage,
  });
  final ProgressScoreEntity? examScoreData;
  final double? percentageDecimal;
  final String? percentage;
  ExamScoreInitial copyWith({
    ProgressScoreEntity? examScoreData,
    double? percentageDecimal,
    String? percentage,
  }) {
    return ExamScoreInitial(
      examScoreData: examScoreData ?? this.examScoreData,
      percentage: percentage ?? this.percentage,
      percentageDecimal: percentageDecimal ?? this.percentageDecimal,
    );
  }

  @override
  List<Object?> get props => [examScoreData, percentageDecimal, percentage];
}
*
* */
