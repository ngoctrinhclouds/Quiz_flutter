import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_flutter/models/question_model.dart';
import 'package:quiz_flutter/remote/service/response/base_response.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse extends BaseResponse {
  @JsonKey(name: 'results')
  List<QuestionModel>? dataList;

  QuestionResponse();

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}
