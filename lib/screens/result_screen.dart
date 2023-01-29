import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/const.dart';
import 'package:flutterfirebasequiz230129/models/model.dart';
import 'package:flutterfirebasequiz230129/screens/action_button.dart';
import 'package:flutterfirebasequiz230129/screens/quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final int totalTime;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox.expand(
          child: GradientBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Result: $score / ${questions.length}',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                SizedBox(
                  height: 40,
                ),
                ActionButton(
                  title: "다시",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          totalTime: totalTime,
                          questions: questions,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
