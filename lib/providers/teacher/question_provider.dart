import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/models/question.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuestionProvider extends ChangeNotifier {
  var scrollController = ScrollController();
  var totalScoreController = TextEditingController();

  // List of questions
  List<Question> questions = [
    Question(),
  ];

  QuestionProvider();

  Future calculate() async {
    var openQuestions = questions.where((element) => !element.isClose).toList();
    var totalScore = openQuestions.fold(0.0, (previousValue, element) => previousValue + element.score.text.toDouble);
    totalScoreController.text = totalScore.toString();
    notifyListeners();
  }

  Future setTotalScore() async {
    var res = await Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: RGB.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            children: [
              const Spacer(),
              Text(
                "old_scores_maybe_changed".tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
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
                    child: Text("cancel".tr),
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
                    child: Text("agree".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));

    if (res == true) {
      List<Question> openQuestions = questions.where((element) => !element.isClose).toList();
      var avg = totalScoreController.text.toInt / openQuestions.length;

      for (var quest in openQuestions) {
        quest.score.text = avg.toString();
      }

      notifyListeners();
    }
  }

  //Work with API
  bool isLoading = false;

  //Add new question
  void addNewQuestion(BuildContext ctx) {
    if (questions.last.question.text.isEmpty) {
      CustomSnackbars.warning(ctx, "question_cannot_be_empty".tr);
      return;
    }
    if (!questions.last.isClose) {
      if (questions.last.answers.length < 2) {
        CustomSnackbars.warning(ctx, "must_at_least_2_answers".tr);
        return;
      }

      if (questions.last.answers.any((element) => element.answer.text.isEmpty)) {
        CustomSnackbars.warning(ctx, "all_answers_must_be_filled".tr);
        return;
      }

      if (questions.last.answers.length < 2) {
        CustomSnackbars.warning(ctx, "must_at_least_2_answers".tr);
        return;
      }
    }

    var question = Question();

    questions.add(question);
    notifyListeners();

    // //scroll to end
    scrollController.animateTo(
      scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
    );
    notifyListeners();
  }

  //Remove question
  void removeQuestion(BuildContext ctx, question) {
    if (questions.length == 1) {
      CustomSnackbars.warning(ctx, "must_at_least_1_questions".tr);
      return;
    }

    questions.remove(question);
    notifyListeners();
  }

  //Save questions
  int countOfCreatedQuestion = 0;
  Future saveQuestions() async {
    isLoading = true;
    notifyListeners();

    for (var question in questions) {
      question.answers.first.isTrue = 1;
      await HttpServise.POST(
        URL.questionCreate,
        body: question.toJson(),
      );
      countOfCreatedQuestion += 1;
      notifyListeners();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back(result: true);

    isLoading = false;
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }
}
