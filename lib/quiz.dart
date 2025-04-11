import 'package:flutter/material.dart';
import 'package:quiz_app/homescreen.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswer = [];


  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if(selectedAnswer.length == questions.length){
      setState(() {
        activeScreen = 'result-screen';
      });

    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }
  void restartQuiz(){
    setState(() {
      selectedAnswer = [];
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget screenWidget = HomeScreen(switchScreen);

    if (activeScreen == 'question-screen'){
      screenWidget = QuestionScreen(
      onSelectAnswer: chooseAnswer
      );
    }
    if (activeScreen == 'result-screen'){
      screenWidget = ResultScreen(
          chosenAnswers: selectedAnswer,
          onRestart: restartQuiz
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 60, 0, 108),
                Color.fromARGB(255, 135, 1, 176),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: screenWidget,
          ),
        ),
      ),
    );
  }
}
