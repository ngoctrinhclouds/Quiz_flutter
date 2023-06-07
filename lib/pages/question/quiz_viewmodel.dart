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
        ? '${minutes}min $seconds sec'
        : (minutes == 0)
            ? '$seconds sec'
            : '${hours}hr $minutes min  $seconds sec';
  }

  Future<void> fetchDatAPIQuestion() async {
    try {
      final response = api.questionService.getQuestionAll();
    } on DioError catch (ex) {
      print(ex);
    }
  }
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "Who is the owner of Flutter?",
    [
      Answer("Nokia", false),
      Answer("Samsung", false),
      Answer("Google", true),
      Answer("Apple", false),
    ],
  ));

  list.add(Question(
    "Who owns Iphone?",
    [
      Answer("Apple", true),
      Answer("Microsoft", false),
      Answer("Google", false),
      Answer("Nokia", false),
    ],
  ));

  list.add(Question(
    "Youtube is _________  platform?",
    [
      Answer("Music Sharing", false),
      Answer("Video Sharing", false),
      Answer("Live Streaming", false),
      Answer("All of the above", true),
    ],
  ));

  list.add(Question(
    "Flutter is an open-source UI software development kit created by ______",
    [
      Answer("Apple", true),
      Answer("Google", false),
      Answer("Facebook", false),
      Answer("Microsoft", false),
    ],
  ));

  list.add(Question(
    "When google release Flutter.",
    [
      Answer("Jun 2017", false),
      Answer("Jun 2018", true),
      Answer("May 2017", false),
      Answer("May 2018", false),
    ],
  ));
  list.add(Question(
    "A memory location that holds a single letter or number.",
    [
      Answer("Int", true),
      Answer("Double", false),
      Answer("Char", false),
      Answer("Float", false),
    ],
  ));
  list.add(Question(
    "What command do you use to output data to the screen?",
    [
      Answer("Count", false),
      Answer("Cin", false),
      Answer("Count>>", true),
      Answer("Output>>", false),
    ],
  ));

  list.add(Question(
    "Flutter user dart as a language?",
    [
      Answer("True", true),
      Answer("False", false),
    ],
  ));

  return list;
}
