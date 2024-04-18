import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StudentProvider extends ChangeNotifier {
  TextEditingController quizIdController = TextEditingController();

  List subjects = [
    // ...List.generate(10, (index) {
    //   return {
    //     "id": index,
    //     "name": "Math ${index + 1}",
    //   };
    // })
  ];

  Map subject = {};
  void setSubject(Map subject) {
    this.subject = subject;
    notifyListeners();
  }

  StudentProvider() {
    getSubjects();
  }

  Future startQuiz(quizId, subjectid) async {
    isLoading = true;
    notifyListeners();

    Get.toNamed("/quiz", arguments: {
      "quizId": quizId,
      "subjectId": subjectid,
    });
  }

  bool isLoading = false;
  Future getSubjects() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    subjects = List.generate(10, (index) {
      return {
        "id": index,
        "name": "Math ${index + 1}",
      };
    });

    isLoading = false;
    notifyListeners();
  }
}
