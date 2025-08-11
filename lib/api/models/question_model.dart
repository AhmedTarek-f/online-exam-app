import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? type;
  final String? question;
  final String? correct;
  final List<Answer>? answers;
  final Subject? subject;
  final Exam? exam;
  final String? createdAt;

  QuestionModel({
    this.id,
    this.type,
    this.question,
    this.correct,
    this.answers,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class Answer {
  final String? key;
  final String? answer;

  Answer({
    this.key,
    this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) =>
      _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable()
class Exam {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  Exam({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) =>
      _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}

@JsonSerializable()
class Subject {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;

  Subject({this.id, this.name});

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
