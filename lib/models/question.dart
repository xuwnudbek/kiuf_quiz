import 'package:flutter/material.dart';
import 'package:kiuf_quiz/models/answer.dart';

class Question {
  TextEditingController questionText = TextEditingController();
  List<Answer> answers = [];

  //QuestionType
  QuestionType type = QuestionType.open;
  void setType(QuestionType type) {
    if (type == QuestionType.close) {
      answers.clear();
    } else {
      answers.clear();
      answers.addAll([
        ...List.generate(4, (index) => Answer()),
      ]);
    }
    this.type = type;
  }

  //constructor
  Question() {
    answers.addAll([
      ...List.generate(4, (index) => Answer()),
    ]);
  }

  /// [addAnswer] - add new answer
  void addAnswer() {
    answers.add(Answer());
  }

  void removeAnswer(Answer answer) {
    answers.remove(answer);
  }
}

enum QuestionType { open, close }
