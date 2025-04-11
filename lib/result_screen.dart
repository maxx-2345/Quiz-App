import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/homescreen.dart';
import 'package:quiz_app/question_summary.dart';

import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswers, required this.onRestart});

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {

    final summaryData = getSummaryData();
    final numQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data){
      return data['correct_answer'] == data['user_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectQuestions right answers out of $numQuestions!",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            SizedBox(
              height: 30,
            ),
            TextButton.icon(
              icon: Icon(Icons.refresh,color: Colors.white,),
              onPressed: onRestart,
              label: const Text("Restart Quiz",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
