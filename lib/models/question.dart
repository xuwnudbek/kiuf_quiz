import 'package:flutter/material.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';

class Question {
  int quizId = Storage.quizId!;
  TextEditingController question = TextEditingController();
  int? score;
  bool isClose = false;
  List<Answer> answers = List.generate(
    4,
    (index) => Answer(answer: TextEditingController()),
  );

  Map<String, dynamic> toJson() {
    return {
      "quiz_id": quizId,
      "question": question.text,
      "score": score ?? 0,
      "is_close": isClose ? 1 : 0,
      "answers": answers.map((e) => e.toJson()).toList(),
    };
  }

  void addAnswer() {
    answers.add(Answer(answer: TextEditingController()));
  }

  void removeAnswer(Answer answer) {
    answers.remove(answer);
  }
}

class Answer {
  TextEditingController answer;
  int isTrue = 0;

  Answer({required this.answer});

  Map<String, dynamic> toJson() {
    return {
      "answer": answer.text,
      "is_true": isTrue,
    };
  }
}


/*

{
    "quiz_id": 9841414313,
    "question": "Nimami?",
    "score": 2,
    "is_close": 0,
    "answers": [
        {
            "answer": "Ha",
            "is_true": 1
        },
        {
            "answer": "Yo'q",
            "is_true": 0
        },
        {
            "answer": "Bilmadim",
            "is_true": 0
        },
        {
            "answer": "Shunaqa shekilli",
            "is_true": 0
        }
    ]
}


*/