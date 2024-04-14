import 'package:flutter/material.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';

class QuizProvider extends ChangeNotifier {
  List departmentList = [];
  Map department = {}; //dep_id
  setDepartment(Map dep) {
    department = dep;
    notifyListeners();
  }

  List courseList = [];
  Map course = {}; //course_id
  setCourse(Map crs) {
    course = crs;
    notifyListeners();
  }

  List typeList = [];
  Map type = {}; //0 - open, 1 - closed
  setType(Map tp) {
    type = tp;
    notifyListeners();
  }

  List subjectList = [];
  Map subject = {}; //subject_id
  setSubject(Map sbj) {
    subject = sbj;
    notifyListeners();
  }

  DateWithTime? dateWithTime;
  setDateWithTime(DateWithTime dt) {
    dateWithTime = dt;
    notifyListeners();
  }

  QuizProvider();

  bool isCreating = false;

  // Create New Quiz
  Future createQuiz() async {
    isCreating = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    isCreating = false;
    notifyListeners();
  }

  // Update Quiz
  Future updateQuiz() async {
    isCreating = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    isCreating = false;
    notifyListeners();
  }
}
