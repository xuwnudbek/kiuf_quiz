import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';

class ShowQuizProvider extends ChangeNotifier {
  Map quiz = {};
  List questions = [];

  ShowQuizProvider() {
    initialize();
  }

  void initialize() async {
    if (Storage.quizId == null) {
      Get.back();
    }

    await getQuiz(Storage.quizId.toString());
  }

  bool isLoading = false;

  Future deleteQuestion(quizId) async {
    await HttpServise.POST(
      "${URL.questionDelete}/$quizId",
    );
  }

  Future getQuiz(String id) async {
    isLoading = true;
    notifyListeners();

    var res = await HttpServise.GET("${URL.quiz}/$id");

    if (res.status == HttpResponses.success) {
      quiz = res.data;
      questions = res.data['questions'];
    }

    isLoading = false;
    notifyListeners();
  }
}


/*
{
  "id": 2,
  "quiz_id": 9841414313,
  "question": "Nimami?",
  "score": 2,
  "is_close": 0,
  "created_at": "2024-04-20T07:30:38.000000Z",
  "updated_at": "2024-04-20T07:30:38.000000Z",
  "answers": [
      {
          "id": 5,
          "question_id": 2,
          "answer": "Ha",
          "created_at": "2024-04-20T07:30:38.000000Z",
          "updated_at": "2024-04-20T07:30:38.000000Z",
          "is_true": 1
      },
      {
          "id": 6,
          "question_id": 2,
          "answer": "Yo'q",
          "created_at": "2024-04-20T07:30:38.000000Z",
          "updated_at": "2024-04-20T07:30:38.000000Z",
          "is_true": 0
      },
      {
          "id": 7,
          "question_id": 2,
          "answer": "Bilmadim",
          "created_at": "2024-04-20T07:30:38.000000Z",
          "updated_at": "2024-04-20T07:30:38.000000Z",
          "is_true": 0
      },
      {
          "id": 8,
          "question_id": 2,
          "answer": "Shunaqa shekilli",
          "created_at": "2024-04-20T07:30:38.000000Z",
          "updated_at": "2024-04-20T07:30:38.000000Z",
          "is_true": 0
      }
  ]
},

*/