// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

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
    }

    calculateScores();

    isSearching = false;
    notifyListeners();
  }

  int totalScore = 0;
  int totalCloseQuestionsScore = 0;
  Map closeQuestionsScores = {};

  void calculateCloseQuestionsScore() {
    totalCloseQuestionsScore = 0;
    for (var closeQuestionsScore in closeQuestionsScores.entries) {
      totalCloseQuestionsScore += closeQuestionsScore.value.text.toString().toInt;
    }
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

  //downloadStudentResultsAsPDF

  bool isDownloading = false;
  Future<void> downloadStudentResultsAsPDF(BuildContext ctx) async {
    isDownloading = true;
    notifyListeners();

    var res = await HttpServise.GETPDF(
      "${URL.downloadStudentResultsAsPDF}/${Storage.quizId}/${student['loginId']}",
    );

    if (res != null) {
      html.Blob blob = html.Blob([res.bodyBytes]);

      var anchor = html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob));
      anchor
        ..download = '${student['name']}.pdf'
        ..click();
    } else {
      CustomSnackbars.error(ctx, "error_with_download".tr);
    }

    isDownloading = false;
    notifyListeners();
  }

  Future exportAllStudentToPdf(BuildContext ctx) async {
    var res = await HttpServise.GETPDF(
      "${URL.downloadAllStudentresults}/${Storage.quizId}",
    );
    inspect(res);

    if (res != null && res.statusCode == 200) {
      List data = jsonDecode(res.body);

      for (var one in data) {
        var studentName = one['studentName'];
        var pdfBase64 = one['pdfBase64'];

        var bytes = base64Decode(pdfBase64);
        var blob = html.Blob([bytes]);
        var anchor = html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob));
        anchor
          ..download = '$studentName.pdf'
          ..click();
      }
    } else {
      CustomSnackbars.error(ctx, "error_with_download".tr);
    }
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