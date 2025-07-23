import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entities/subjects/subjects_entity.dart';
import 'package:online_exam_app/domain/repositories/subjects/subject_repository.dart';

@injectable
class SubjectUseCase {
  final SubjectRepository _subjectRepository;
  @factoryMethod
  const SubjectUseCase(this._subjectRepository);

  Future<List<SubjectsEntity>> invoke() async =>
      await _subjectRepository.getSubjects();
}
