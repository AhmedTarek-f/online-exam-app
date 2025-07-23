import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source/subjects/subject_remote_data_source.dart';
import 'package:online_exam_app/domain/entities/subjects/subjects_entity.dart';
import 'package:online_exam_app/domain/repositories/subjects/subject_repository.dart';

@Injectable(as: SubjectRepository)
class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectRemoteDataSource subjectRemoteDataSource;

  @factoryMethod
  SubjectRepositoryImpl({required this.subjectRemoteDataSource});
  @override
  Future<List<SubjectsEntity>> getSubjects() => subjectRemoteDataSource.getSubjects();
}
