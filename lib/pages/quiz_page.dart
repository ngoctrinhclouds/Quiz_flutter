import 'package:flutter/material.dart';
import 'package:quiz_flutter/pages/home_page.dart';
import 'package:quiz_flutter/pages/question_viewmodel.dart';

import '../resources/app_color.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => const HomePage(), icon: const Icon(Icons.close))
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
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "/${questionList.length.toString()}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
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
                  questionList[currentQuestionIndex].questionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.redAccent : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
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
            Text(answer.answerText),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 48,
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
        child: Text(isLastQuestion ? "Submit" : "Next"),
      ),
    );
  }

  _showScoreDialog() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
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
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black54),
          ),
          Text(
            title1,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
          Text(
            "$score/${currentQuestionIndex + 1}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), primary: Colors.redAccent),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex = 0;
              score = 0;
              selectedAnswer = null;
            });
          },
          child: const Text("Play Again"),
        ),
      ),
    );
  }
}
