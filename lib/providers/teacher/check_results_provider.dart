import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class CheckResultsProvider extends ChangeNotifier {
  // Add your code here

  var studentIdController = TextEditingController();

  //Subjects
  List subjects = [];
  Map subject = {};
  void setSubject(subject) {
    this.subject = subject;
    notifyListeners();
  }

  bool isLoading = false;

  CheckResultsProvider() {
    init();
  }

  init() async {
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

  Map student = {};
  void setStudent(student) {
    this.student = student;
    notifyListeners();
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

  Future getStudentQuestions(ctx) async {
    isSearching = true;
    notifyListeners();

    Map body = {
      "quiz_id": Storage.quizId,
      "student_id": student['loginId'],
    };

    print(body);

    var res = await HttpServise.POST(
      URL.studentQuestions,
      body: body,
    );

    if (res.status == HttpResponses.success) {
      studentQuestions = res.data;
    }

    isSearching = false;
    notifyListeners();
  }
}

/**
{
  "quiz": {
      "id": 9841414313,
      "dep_id": 2,
      "course_id": 2,
      "type": 0,
      "user_id": 7,
      "subject_id": 5,
      "created_at": "2024-04-19T16:12:21.000000Z",
      "updated_at": "2024-04-21T18:13:12.000000Z",
      "start_time": "2024-04-21 08:20:00",
      "end_time": "2024-04-21 09:30:00"
  },
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
        },
        {
            "id": 81,
            "question_id": 23,
            "answer": "Yo'q",
            "created_at": "2024-04-20T17:59:42.000000Z",
            "updated_at": "2024-04-20T17:59:42.000000Z",
            "is_true": 0
        },
        {
            "id": 82,
            "question_id": 23,
            "answer": "Bilmadim",
            "created_at": "2024-04-20T17:59:42.000000Z",
            "updated_at": "2024-04-20T17:59:42.000000Z",
            "is_true": 0
        },
        {
            "id": 83,
            "question_id": 23,
            "answer": "Shunaqa shekilli",
            "created_at": "2024-04-20T17:59:42.000000Z",
            "updated_at": "2024-04-20T17:59:42.000000Z",
            "is_true": 0
        }
    ]
  },
  "student": {
      "loginId": 2223141011,
      "name": "Jamshidbek Aliyev Mirzohidjon o'g'li",
      "faculty": "Internet va Axborot Kommunikatsiyasi",
      "passportNumber": "AD0599965",
      "course": 2,
      "created_at": null,
      "updated_at": null
  },
  "answer": null,
  "answer_id": 96,
  "score": 0
}
*/