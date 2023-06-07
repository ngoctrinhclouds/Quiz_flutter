// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel()
      ..id = json['id'] as int?
      ..category = json['category'] as String?
      ..type = json['type'] as String?
      ..difficulty = json['difficulty'] as String?
      ..question = json['question'] as String?
      ..correct_answer = json['correct_answer'] as String?
      ..incorrect_answers = (json['incorrect_answers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'question': instance.question,
      'correct_answer': instance.correct_answer,
      'incorrect_answers': instance.incorrect_answers,
    };
