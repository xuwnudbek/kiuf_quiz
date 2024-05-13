import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CheckResultsProvider extends ChangeNotifier {
  // Add your code here
  var studentIdController = TextEditingController();

  //Student
  Map student = {};
  void setStudent(student) {
    this.student = student;
    getStudentQuestions();
    notifyListeners();
  }

  //Subjects
  List subjects = [];
  Map subject = {};
  void setSubject(subject) {
    this.subject = subject;
    notifyListeners();
  }

  CheckResultsProvider() {
    init();
  }

  bool isLoading = false;
  bool isUpdating = false;
  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    await getTeacherSubjects();
    await getQuizStudents();

    isLoading = false;
    notifyListeners();
  }

  Future getTeacherSubjects() async {
    var res = await HttpServise.GET(URL.teacherSubjects);

    if (res.status == HttpResponses.success) {
      subjects.clear();
      subjects.addAll(res.data);
      notifyListeners();
    }
  }

  List quizStudents = [];
  Future getQuizStudents() async {
    var res = await HttpServise.GET(
      "${URL.quizStudents}/${Storage.quizId}",
    );

    if (res.status == HttpResponses.success) {
      quizStudents.clear();
      quizStudents.addAll(res.data);
      notifyListeners();
    }
  }

  bool isSearching = false;
  List studentQuestions = [];

  Future getStudentQuestions() async {
    isSearching = true;
    notifyListeners();

    Map body = {
      "quiz_id": Storage.quizId,
      "student_id": student['loginId'],
    };

    var res = await HttpServise.POST(
      URL.studentQuestions,
      body: body,
    );

    if (res.status == HttpResponses.success) {
      studentQuestions = res.data;
      inspect(res.data);
    }

    calculateScores();

    isSearching = false;
    notifyListeners();
  }

  int totalScore = 0;
  int totalCloseQuestionsScore = 0;
  Map closeQuestionsScores = {};

  void calculateCloseQuestionsScore() {
    log("totalCloseQuestionsScore: $totalCloseQuestionsScore");
    log("totalScore1: $totalScore");
    totalCloseQuestionsScore = 0;
    for (var closeQuestionsScore in closeQuestionsScores.entries) {
      totalCloseQuestionsScore += closeQuestionsScore.value.text.toString().toInt;
    }
    log("totalScore2: $totalScore");
    notifyListeners();
  }

  void calculateScores() {
    totalScore = 0;

    for (Map studentQuestion in studentQuestions) {
      Map question = studentQuestion['question'];
      bool isOpen = question['is_close'] == 0;
      int questionScore = studentQuestion['score'] ?? 0;
      List answers = question['answers'];

      if (isOpen) {
        var answerId = studentQuestion['answer_id'];
        var answer = answers.firstWhere((element) => element['id'] == answerId);

        if (answer != null && answer['is_true'] == 1) {
          totalScore += questionScore;
        }
      } else {
        closeQuestionsScores[question['id']] = TextEditingController(
          text: questionScore == 0 ? "" : questionScore.toString(),
        );
      }
    }

    notifyListeners();
  }

  Future<void> saveQuestions() async {
    if (closeQuestionsScores.isEmpty) {
      await Get.dialog(Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              color: RGB.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
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
                        Get.back();
                      },
                      child: Text("ok".tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
    }

    isUpdating = true;
    notifyListeners();

    for (var closeQuestion in closeQuestionsScores.entries) {
      String score = closeQuestion.value.text;

      Map body = {
        "student_id": "${student['loginId']}",
        "question_id": closeQuestion.key.toString(),
        "score": score.isEmpty ? 0 : score,
      };

      var res = await HttpServise.POST(
        URL.studentAnswerUpdate,
        body: body,
      );
    }

    isUpdating = false;
    notifyListeners();
  }
}

/**
{

  "question": {
    "id": 23,
    "quiz_id": 9841414313,
    "question": "Nimami?",
    "score": 2,
    "is_close": 0,
    "created_at": "2024-04-20T17:59:42.000000Z",
    "updated_at": "2024-04-20T17:59:42.000000Z",
    "answers": [
        {
            "id": 80,
            "question_id": 23,
            "answer": "qwdwdwjiodqoi",
            "created_at": "2024-04-20T17:59:42.000000Z",
            "updated_at": "2024-04-20T17:59:42.000000Z",
            "is_true": 1
        }
    ]
  },
  "answer": null,
  "answer_id": 96,
  "score": 0,
  "student": {
      "loginId": 2223141011,
      "name": "Jamshidbek Aliyev Mirzohidjon o'g'li",
      "faculty": "Internet va Axborot Kommunikatsiyasi",
      "passportNumber": "AD0599965",
      "course": 2,
      "created_at": null,
      "updated_at": null
  },
}
*/