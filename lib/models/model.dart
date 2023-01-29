// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class Question {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  Question copyWith({
    String? id,
    String? question,
    List<String>? answers,
    String? correctAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      answers: List<String>.from(map['answers']),
      correctAnswer: map['correctAnswer'],
    );
  }

  //firebase connect fatch
  factory Question.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;

    data['id'] = id;

    return Question.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && other.question == question && listEquals(other.answers, answers) && other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^ question.hashCode ^ answers.hashCode ^ correctAnswer.hashCode;
  }
}
//
// List<Question> questionss = [
//   Question(
//     id: '1',
//     question: 'what a u?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '2',
//   ),
//   Question(
//     id: '2',
//     question: 'what a u7?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '4',
//   ),
//   Question(
//     id: '3',
//     question: 'what a u6?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '1',
//   ),
//   Question(
//     id: '4',
//     question: 'what a u?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '2',
//   ),
//   Question(
//     id: '5',
//     question: 'what a u6?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '3',
//   ),
//   Question(
//     id: '6',
//     question: 'what a u5?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '4',
//   ),
//   Question(
//     id: '7',
//     question: 'what a u?4',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '2',
//   ),
//   Question(
//     id: '8',
//     question: 'what a u3?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '1',
//   ),
//   Question(
//     id: '9',
//     question: 'what a u2?2',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '1',
//   ),
//   Question(
//     id: '10',
//     question: 'what a u1?',
//     answers: ['1', '2', '3', '4'],
//     correctAnswer: '2',
//   ),
// ];
