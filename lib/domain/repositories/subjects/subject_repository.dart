import 'package:online_exam_app/domain/entities/subjects/subjects_entity.dart';

abstract class SubjectRepository {
  Future<List<SubjectsEntity>> getSubjects();
}
