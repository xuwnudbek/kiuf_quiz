import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuizProvider extends ChangeNotifier {
  late TabController tabController;

  Map quiz = {};
  List questions = [];

  Map<int, dynamic> answers = {};
  void addAnswer(int questionId, dynamic ans) {
    var hasContains = answers.containsKey(questionId);
    answers[questionId] = ans;

    notifyListeners();
  }

  bool checkQuestionSelection(questionId) {
    var hasContains = answers.containsKey(questionId);

    if (hasContains) {
      return true;
    }

    return false;
  }

  bool checkSelection(answer) {
    var hasContains = answers.containsKey(answer['question_id']) && answers.containsValue(answer['id']);

    if (hasContains) {
      return true;
    }

    return false;
  }

  bool isLoading = false;
  bool isSaving = false;

  String _timer = "00:00:00";
  String get timer => _timer;
  set timer(value) {
    _timer = value;
  }

  late Timer _timerPeriodic;

  QuizProvider(TickerProvider tickerProvider, context) {
    _timerPeriodic = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimer();
    });
    init(tickerProvider, context);
  }

  void _calculateTimer() {
    var endTime = quiz['end_time'].toString().toDateTime;
    var now = DateTime.now();
    var leftTime = endTime.difference(now);
    var hours = leftTime.inSeconds ~/ 3600;
    var minute = (leftTime.inSeconds - hours * 3600) ~/ 60;
    var seconds = (leftTime.inSeconds - hours * 3600 - minute * 60);
    timer = "${hours < 10 ? "0$hours" : "$hours"}:${minute < 10 ? "0$minute" : "$minute"}:${seconds < 10 ? "0$seconds" : "$seconds"}";
    notifyListeners();

    if (hours == 0 && minute == 0 && seconds < 1) {
      finish();
    }
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
      questions = res.data['questions'];
      questions.shuffle();
      for (var question in questions) {
        question['answers'].shuffle();
      }
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

  List<bool> statuses = [];

  Future finish() async {
    var res = await Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 175,
          decoration: BoxDecoration(
            color: RGB.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "really_want_to_finish_this_quiz".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "dont_calculate_without_answered_question".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text("no".tr),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: RGB.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: Text("yes".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));

    if (res != true) return false;

    isSaving = true;
    notifyListeners();

    for (var question in questions) {
      if (!answers.containsKey(question['id'])) {
        continue;
      }
      var answerId = answers[question['id']];

      Map<String, dynamic> body = {
        "student_id": Storage.user['loginId'],
        "quiz_id": quiz['id'],
        "question_id": question['id'],
      }
        ..addIf(question["is_close"] == 1, "answer", "")
        ..addIf(question["is_close"] == 0, "answer_id", answerId);

      var res = await HttpServise.POST(
        URL.studentAnswers,
        body: body,
      );

      if (res.status != HttpResponses.success) {
        statuses.add(true);
      } else {
        statuses.add(false);
      }
    }

    statuses.clear();

    isSaving = false;
    notifyListeners();

    return true;
  }

  Future<bool> quit() async {
    var res = await Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 175,
          decoration: BoxDecoration(
            color: RGB.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "really_want_to_stop_this_quiz".tr,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text("no".tr),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: RGB.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: Text("yes".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));

    if (res == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _timerPeriodic.cancel();
    super.dispose();
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