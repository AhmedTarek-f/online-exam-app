import 'package:online_exam_app/api/requests/question_request/question_request.dart';

import '../../../../api/models/question_model.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> fetchQuestions(String token,String examId);
}
