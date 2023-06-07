
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'response/question_response.dart';

part 'question_service.g.dart';

@RestApi()
abstract class QuestionService {
  factory QuestionService(Dio dio, {String baseUrl}) = _QuestionService;

  @GET('/api.php?amount=5')
  Future<QuestionResponse> getQuestionAll();
}