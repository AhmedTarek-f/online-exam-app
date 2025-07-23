// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectsResponse _$SubjectsResponseFromJson(Map<String, dynamic> json) =>
    SubjectsResponse(
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectsResponseToJson(SubjectsResponse instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
    };

SubjectItemResponse _$SubjectItemResponseFromJson(Map<String, dynamic> json) =>
    SubjectItemResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SubjectItemResponseToJson(
        SubjectItemResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt.toIso8601String(),
    };
