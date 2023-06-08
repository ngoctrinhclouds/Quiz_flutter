import 'package:flutter/material.dart';
import 'package:quiz_flutter/base/base_page.dart';
import 'package:quiz_flutter/pages/home_page.dart';
import 'package:quiz_flutter/pages/question/quiz_viewmodel.dart';

import '../../models/answer_model.dart';
import '../../models/questions_modell.dart';
import '../../resources/app_color.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with MixinBasePage<QuizVM> {
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builder(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      ),
                  icon: const Icon(Icons.close)),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 5, 50, 80),
          body: Center(
            child: SafeArea(
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Question ${currentQuestionIndex + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "/${provider.list.length.toString()}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      provider.list.isNotEmpty ? provider.list[currentQuestionIndex].questionText :"" ,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _answerList(),
                  const SizedBox(height: kDefaultPadding),
                  _nextButton(),
                ],
              ),
            ),
          ),
        ));
  }

  _answerList() {
    return provider.list.isEmpty
        ? const SizedBox()
        : Column(
            children: provider.list[currentQuestionIndex].answersList
                .map(
                  (e) => _answerButton(e),
                )
                .toList(),
          );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? Colors.red : Colors.white)),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: isSelected ? Colors.red : Colors.white,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(answer.answerText, textAlign: TextAlign.start,),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                value: isSelected,
                checkColor: Colors.red,
                activeColor: const Color.fromARGB(255, 5, 50, 80),
                onChanged: (value) {
                  setState(() {
                    isSelected = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == provider.list.length - 1) {
      isLastQuestion = true;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.redAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (isLastQuestion) {
            //display score

            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
        child: Text(
          isLastQuestion ? "Submit" : "Next",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  _showScoreDialog() {
    provider.endTimeQuestion();
    String timeQuestion =
        provider.calTotalTime(provider.startTime, provider.endTime);
    print(timeQuestion);
    bool isPassed = false;

    if (score >= provider.list.length * 0.6) {
      //pass if 60 %
      isPassed = true;
    }
    String title = isPassed ? "Congratulations!!" : "Completed!";
    String title1 = isPassed ? "You are amazing!!" : "Better luck next time!";
    return AlertDialog(
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
          Text(
            title1,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
          Text(
            "$score/${currentQuestionIndex + 1} correct answers in $timeQuestion",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 46,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex = 0;
              score = 0;
              selectedAnswer = null;
            });
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), primary: Colors.red),
          child: const Text(
            "Play Again",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  @override
  QuizVM create() {
    return QuizVM();
  }

  @override
  void initialise(BuildContext context) {}
}
