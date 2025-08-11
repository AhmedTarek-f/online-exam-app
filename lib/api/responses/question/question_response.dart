import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/api/requests/question_request/question_request.dart';

import '../../models/question_model.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  final String? message;
  final List<QuestionModel>? questions;

  QuestionResponse({
    this.message,
    this.questions,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}
