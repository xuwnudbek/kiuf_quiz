import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/models/question.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuestionProvider extends ChangeNotifier {
  var scrollController = ScrollController();

  // List of questions
  final List<Question> questions = [
    Question(),
  ];

  // QuestionProvider() {}

  void addNewQuestion(BuildContext ctx) {
    //Validate
    var lastQuestion = questions.last;
    if (lastQuestion.questionText.text.isEmpty) {
      CustomSnackbars.warning(ctx, "must_fill_old_question".tr);
      return;
    }
    if (lastQuestion.type == QuestionType.open && lastQuestion.answers.where((element) => element.text.text.isEmpty).isNotEmpty) {
      CustomSnackbars.error(ctx, "error_while_add_new_question".tr);
      return;
    }

    var question = Question();
    questions.add(question);

    //scroll to end
    scrollController.animateTo(
      scrollController.position.extentTotal,
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
    );
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }

  void removeQuestion(BuildContext ctx, Question question) {
    if (questions.length == 1) {
      CustomSnackbars.warning(ctx, "must_at_least_2_questions".tr);
      return;
    }

    questions.remove(question);
    notifyListeners();
  }

  //Work with API
  bool isLoading = false;
  void saveQuestions() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }
}
