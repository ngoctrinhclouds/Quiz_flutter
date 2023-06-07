
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'difficulty')
  String? difficulty;

  @JsonKey(name: 'question')
  String? question;

  @JsonKey(name: 'correct_answer')
  String? correct_answer;

  @JsonKey(name: 'incorrect_answers')
  List<String>? incorrect_answers;

  QuestionModel();

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

}