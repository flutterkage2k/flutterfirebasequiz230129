import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/auth/quiz_service.dart';
import 'package:flutterfirebasequiz230129/models/model.dart';

class QuizProvider extends ChangeNotifier {
  int totalTime = 0;
  List<Question> questions = [];

  QuizProvider() {
    QuizService.getAllQuestions().then((value) {
      questions = value;
      notifyListeners();
    });

    QuizService.getTotalTime().then((value) {
      totalTime = value;
      notifyListeners();
    });
  }
}
