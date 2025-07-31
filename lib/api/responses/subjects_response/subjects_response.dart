import 'package:json_annotation/json_annotation.dart';

part 'subjects_response.g.dart';

@JsonSerializable()
class SubjectsResponse {
  @JsonKey(name: "subjects")
  final List<SubjectItemResponse> subjects;

  SubjectsResponse({
    required this.subjects,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseToJson(this);
}

@JsonSerializable()
class SubjectItemResponse {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "icon")
  final String icon;

  @JsonKey(name: "createdAt")
  final DateTime createdAt;

  SubjectItemResponse({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory SubjectItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectItemResponseToJson(this);
}
