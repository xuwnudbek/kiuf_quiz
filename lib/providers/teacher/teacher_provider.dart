import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/functions/check_status.dart';

class TeacherProvider extends ChangeNotifier {
  //Subjects
  List quizzes = [];
  List filteredQuizzes = [];

  bool isFiltering = false;
  void filterQuizzes() {
    isFiltering = true;
    notifyListeners();

    filteredQuizzes = quizzes;

    //Filter by Subject
    if (subject.isNotEmpty) {
      filteredQuizzes = filteredQuizzes.where((element) => element["subject"] == subject['name']).toList();
    }

    //Filter by Department
    if (department.isNotEmpty) {
      filteredQuizzes = filteredQuizzes.where((element) => element["department"] == department['name']).toList();
    }

    //Filter by Course
    if (course.isNotEmpty) {
      filteredQuizzes = filteredQuizzes.where((element) => element["course"] == (course['name'].toString().substring(0, 1))).toList();
    }

    if (status.isNotEmpty) {
      filteredQuizzes = filteredQuizzes.where((element) {
        var startTime = element['start_time'].toString().toDateTime;
        var endTime = element['end_time'].toString().toDateTime;

        var statusId = checkStatus(startTime, endTime);

        if (statusId == status['id']) {
          return true;
        }

        return false;
      }).toList();
    }

    isFiltering = false;
    notifyListeners();
  }

  //Subjects
  List subjects = [];
  Map subject = {};
  void setSubject(subject) {
    this.subject = subject;
    notifyListeners();
    filterQuizzes();
  }

  //Departments
  List departments = [];
  Map department = {};
  void setDepartment(department) {
    this.department = department;
    notifyListeners();
    filterQuizzes();
  }

  //Courses
  List courses = [];
  Map course = {};
  void setCourse(course) {
    this.course = course;
    notifyListeners();
    filterQuizzes();
  }

  //Statuses
  List statuses = [
    {"id": 1, "name": "Boshlanmagan"},
    {"id": 2, "name": "Jarayonda"},
    {"id": 3, "name": "Tugagan"},
  ];

  Map status = {};
  void setStatus(status) {
    this.status = status;
    notifyListeners();
    filterQuizzes();
  }

  //Default Constructor
  TeacherProvider() {
    init();
  }

  bool isLoading = false;
  Future init() async {
    isLoading = true;
    notifyListeners();

    await getTeacherSubjects();
    await getTeacherDepartments();
    await getTeacherCourses();
    await getTeacherQuizzes();

    filterQuizzes();

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
    } else {
      print(res);
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

  Future getTeacherQuizzes() async {
    var res = await HttpServise.GET(URL.teacherQuizzes);

    if (res.status == HttpResponses.success) {
      quizzes.clear();
      quizzes.addAll(res.data);
      notifyListeners();
    }
  }

  void clear() {
    subject = {};
    department = {};
    course = {};
    status = {};

    filterQuizzes();
  }
}
