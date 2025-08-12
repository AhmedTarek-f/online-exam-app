import 'package:json_annotation/json_annotation.dart';

part 'question_request.g.dart';

@JsonSerializable()
class QuestionRequest {
  @JsonKey(name: "exam_id")
  final String examId;

  QuestionRequest({required this.examId});

  factory QuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$QuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRequestToJson(this);
}
