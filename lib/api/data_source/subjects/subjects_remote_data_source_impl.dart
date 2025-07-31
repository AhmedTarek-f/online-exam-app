import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/client/api_client.dart';
import 'package:online_exam_app/data/data_source/subjects/subject_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/subjects/subjects_entity.dart';
import 'package:online_exam_app/utils/exam_method_helper.dart';

@Injectable(as: SubjectRemoteDataSource)
class SubjectsRemoteDataSourceImpl implements SubjectRemoteDataSource {
  final ApiClient apiClient;
  @factoryMethod
  SubjectsRemoteDataSourceImpl(this.apiClient);
  @override
  Future<List<SubjectsEntity>> getSubjects() async {
    var response =
        await apiClient.getSubjects(token: ExamMethodHelper.currentUserToken!);
    return response.subjects.map((e) => SubjectsEntity(
      id: e.id,
      name: e.name,
      icon: e.icon,
      createdAt: e.createdAt,
    )).toList();
  }
}
