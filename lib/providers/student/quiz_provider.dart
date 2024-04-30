import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuizProvider extends ChangeNotifier {
  late TabController tabController;

  Map quiz = {};
  List questions = [];
  List answers = [];

  void addAnswer(question) {}

  bool isLoading = false;
  QuizProvider(TickerProvider tickerProvider, context) {
    init(tickerProvider, context);
  }

  void init(ticker, context) async {
    isLoading = true;
    notifyListeners();

    await getQuiz(context);
    tabController = TabController(length: questions.length, vsync: ticker);

    isLoading = false;
    notifyListeners();
  }

  Future getQuiz(ctx) async {
    var res = await HttpServise.GET("${URL.quiz}/${Storage.quizId}");

    if (res.status == HttpResponses.success) {
      quiz = res.data;
      log(quiz.toString());
      questions = res.data['questions'];
    } else {
      CustomSnackbars.error(ctx, "Testni boshlashda xatolik yuz berdi!");
      Get.back();
    }
  }

  void goToPrev() {
    if (tabController.index == 0) return;
    animateTo(tabController.index - 1);
  }

  void goToNext() {
    if (tabController.index == tabController.length - 1) return;
    animateTo(tabController.index + 1);
  }

  void animateTo(index) {
    tabController.animateTo(index);
    notifyListeners();
  }
}


/*
{
  id: 7434412709,
  department: Qurilish,
  course: 2,
  type: 0,
  user: Xuwnudbek,
  subject: Gidravlika,
  start_time: 2024-04-19 09:00:00,
  end_time: 2024-04-19 10:25:00,
  questions: [],
  answers: null,
}
*/