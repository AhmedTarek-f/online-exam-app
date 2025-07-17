import 'package:equatable/equatable.dart';

sealed class ExamScoreState extends Equatable {}

final class ExamScoreInitial extends ExamScoreState {
  @override
  List<Object?> get props => [];
}

/*
*
*   const ExamScoreState({this.scoreData});
  final ProgressScoreEntity? scoreData;
  @override
  List<Object?> get props => [scoreData];
*
* */
