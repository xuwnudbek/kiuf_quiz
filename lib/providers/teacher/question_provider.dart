import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/models/question.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuestionProvider extends ChangeNotifier {
  var scrollController = ScrollController();

  // List of questions
  List<Question> questions = [
    Question(),
  ];

  QuestionProvider();

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
