import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebasequiz230129/models/model.dart';

class QuizService {
  static Future<List<Question>> getAllQuestions() async {
    final questionsRef = FirebaseFirestore.instance.collection('questions');
    final questionDoc = await questionsRef.get();

    return questionDoc.docs.map((e) => Question.fromQueryDocumentSnapshot(e)).toList();
  }

  static Future<int> getTotalTime() async {
    final configRef = FirebaseFirestore.instance.collection('config');
    final configDoc = await configRef.get();

    final config = configDoc.docs.first.data();
    return config['key'];
  }
}
