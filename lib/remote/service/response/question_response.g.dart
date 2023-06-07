// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResponse _$QuestionResponseFromJson(Map<String, dynamic> json) =>
    QuestionResponse()
      ..error = json['error'] as int?
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..dataList = (json['results'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$QuestionResponseToJson(QuestionResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'results': instance.dataList,
    };
