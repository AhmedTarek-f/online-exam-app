import 'package:online_exam_app/utils/exceptions/response_exception.dart';

abstract class Failure {
  const Failure({required this.errorMessage, this.responseException});
  final String errorMessage;
  final ResponseException? responseException;
}
