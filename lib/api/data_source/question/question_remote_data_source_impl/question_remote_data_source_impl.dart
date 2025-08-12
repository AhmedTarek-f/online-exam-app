import 'package:injectable/injectable.dart';
import 'package:online_exam_app/api/requests/question_request/question_request.dart';

import '../../../../data/data_source/question/remote_data_source/question_remote_data_source.dart';
import '../../../client/api_client.dart';
import '../../../models/question_model.dart';

@Injectable(as: QuestionRemoteDataSource)
class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final ApiClient apiClient;

  @factoryMethod
  QuestionRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<QuestionModel>> fetchQuestions(String token, String examId) async {
    final response = await apiClient.getQuestions(token, examId);
    return response.questions ?? [];
  }
}
