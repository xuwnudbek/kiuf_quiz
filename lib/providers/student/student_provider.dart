import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';

class StudentProvider extends ChangeNotifier {
  TextEditingController quizIdController = TextEditingController();

  List studentQuizzes = [];

  Map subject = {};
  void setSubject(Map subject) {
    this.subject = subject;
    notifyListeners();
  }

  StudentProvider() {
    getQuizzes();
  }

  bool isLoading = false;
  Future getQuizzes() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpServise.GET(URL.studentQuizzes);

    if (res.status == HttpResponses.success) {
      studentQuizzes = res.data;
    }

    isLoading = false;
    notifyListeners();
  }
}
