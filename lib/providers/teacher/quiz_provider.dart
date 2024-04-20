import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/extensions/datetime.dart';
import 'package:kiuf_quiz/utils/extensions/time_of_day.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';

class QuizProvider extends ChangeNotifier {
  List departments = [];
  Map department = {}; //dep_id
  setDepartment(Map dep) {
    department = dep;
    notifyListeners();
  }

  List courses = [];
  Map course = {}; //course_id
  setCourse(Map crs) {
    course = crs;
    notifyListeners();
  }

  List types = [
    {"id": 0, "name": "Oraliq"},
    {"id": 1, "name": "Yakuniy"}
  ];
  Map type = {}; //0 - open, 1 - closed
  setType(Map tp) {
    type = tp;
    notifyListeners();
  }

  List subjects = [];
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

  bool isCreating = false;

  QuizProvider() {
    init();
  }

  bool isLoading = false;
  Future init() async {
    isLoading = true;
    notifyListeners();

    await getTeacherSubjects();
    await getTeacherDepartments();
    await getTeacherCourses();

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

  Future getTeacherDepartments() async {
    var res = await HttpServise.GET(URL.teacherDepartments);

    if (res.status == HttpResponses.success) {
      departments.clear();
      departments.addAll(res.data);
      notifyListeners();
    }
  }

  Future getTeacherCourses() async {
    var res = await HttpServise.GET(URL.teacherCourses);

    if (res.status == HttpResponses.success) {
      courses.clear();
      courses.addAll(res.data);

      for (var one in courses) {
        one['name'] = "${one['name']} - ${"course".tr}";
      }

      notifyListeners();
    }
  }

  // Create New Quiz
  Future createQuiz() async {
    isCreating = true;
    notifyListeners();

    var body = {
      "dep_id": department['id'].toString(),
      "course_id": course['id'].toString(),
      "type": type['id'].toString(),
      "user_id": Storage.user['id'].toString(),
      "subject_id": subject['id'].toString(),
      "start_time": "${dateWithTime!.day.toFormattedString()} ${dateWithTime!.from.toFormattedString()}",
      "end_time": "${dateWithTime!.day.toFormattedString()} ${dateWithTime!.to.toFormattedString()}",
    };

    var res = await HttpServise.POST(
      URL.teacherQuizCreate,
      body: body,
    );

    if (res.status == HttpResponses.success) {
      Get.back(result: true);
    }

    isCreating = false;
    notifyListeners();
  }
}
