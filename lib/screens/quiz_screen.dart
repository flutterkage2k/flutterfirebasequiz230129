import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/const.dart';
import 'package:flutterfirebasequiz230129/models/model.dart';
import 'package:flutterfirebasequiz230129/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final int totalTime;
  final List<Question> questions;

  const QuizScreen({Key? key, required this.totalTime, required this.questions}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  String _selectedAnswer = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GradientBox(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                SizedBox(
                  height: height * 0.04,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        LinearProgressIndicator(
                          value: _currentTime / widget.totalTime,
                        ),
                        Center(
                          child: Text(
                            _currentTime.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '문제 ${_currentIndex + 1}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: height * 0.28,
                  child: SingleChildScrollView(
                    child: Text(
                      currentQuestion.question,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final answer = currentQuestion.answers[index];
                      return AnswerTile(
                        isSelected: answer == _selectedAnswer,
                        answer: answer,
                        correctAnswer: currentQuestion.correctAnswer,
                        onTap: () {
                          setState(() {
                            _selectedAnswer = answer;
                          });

                          if (answer == currentQuestion.correctAnswer) {
                            _score++;
                          }

                          Future.delayed(Duration(milliseconds: 200), () {
                            if (_currentIndex == widget.questions.length - 1) {
                              pushResultScreen(context);

                              return;
                            }
                            setState(() {
                              _currentIndex++;
                              _selectedAnswer = '';
                            });
                          });
                        },
                      );
                    },
                    itemCount: widget.questions[_currentIndex].answers.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          questions: widget.questions,
          score: _score,
          totalTime: widget.totalTime,
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  AnswerTile({
    Key? key,
    required this.isSelected,
    required this.answer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          answer,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Color get cardColor {
    if (!isSelected) return Colors.white;
    if (isSelected && answer == correctAnswer) {
      return Colors.yellowAccent;
    }
    return Colors.redAccent;
  }
}
