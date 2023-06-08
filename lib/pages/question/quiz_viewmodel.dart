import 'dart:math';

import 'package:dio/dio.dart';
import 'package:quiz_flutter/base/base_viewmodel.dart';

import '../../models/answer_model.dart';
import '../../models/question_model.dart';
import '../../models/questions_modell.dart';

class QuizVM extends BaseViewModel {
  List<QuestionModel> listData = [];
  List<Question> list = [];
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  void onInit() {
    fetchDatAPIQuestion();
  }

  void startTimeQuestion() {
    startTime = DateTime.now();
  }

  void endTimeQuestion() {
    endTime = DateTime.now();
  }

  ///Calculates the amount of time from a [startTime] and an [endTime].
  String calTotalTime(DateTime startTime, DateTime endTime) {
    Duration difference = startTime.difference(endTime);

    print(difference);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
    return (hours == 0)
        ? '$minutes minutes $seconds seconds'
        : (minutes == 0)
            ? '$seconds seconds'
            : '${hours}hours $minutes minutes  $seconds seconds';
  }

  Future<void> fetchDatAPIQuestion() async {
    showLoading();
    try {
      final response = await api.questionService.getQuestionAll();
      listData.addAll(response.dataList ?? []);
      for (var element in listData) {
        List<Answer> list = [];
        list.add(Answer(element.correct_answer ?? '', true));
        element.incorrect_answers?.forEach((tr) {
          list.add(Answer(tr ?? '', false));
        });

        this.list.add(Question(element.question ?? 'No data', list));
      }
      notifyListeners();
      hideLoading();
    } on DioError catch (ex) {
      print(ex);
      hideLoading();
    }
  }
}
