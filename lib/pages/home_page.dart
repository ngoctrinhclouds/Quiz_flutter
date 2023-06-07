import 'package:flutter/material.dart';
import 'package:quiz_flutter/base/base_page.dart';
import 'package:quiz_flutter/pages/home_viewmodel.dart';
import 'package:quiz_flutter/pages/quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MixinBasePage<HomeVM>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: builder(() => Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/test.png",
            width: 80,
            height: 80,),
            ElevatedButton(
              onPressed: () =>
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizPage(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.red),
              child: const Text('Start Quiz!'),
            ),
          ],
        ),
      )),
    );
  }

  @override
  HomeVM create() => HomeVM();

  @override
  void initialise(BuildContext context) {
    // TODO: implement initialise
  }
}
