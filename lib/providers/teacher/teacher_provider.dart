import 'package:flutter/material.dart';

class TeacherProvider extends ChangeNotifier {
  //Subjects
  List subjects = [
    {"id": 1, "name": "Matematika"},
  ];
  Map subject = {};
  void setSubject(subject) {
    this.subject = subject;
    notifyListeners();
  }

  //Departments
  List departments = [
    {"id": 1, "name": "Axborot texnologiyalari"},
    {"id": 2, "name": "Amaliy matematika"},
  ];
  Map department = {};
  void setDepartment(department) {
    this.department = department;
    notifyListeners();
  }

  //Courses
  List courses = [
    {"id": 1, "name": "1 - kurs"},
    {"id": 2, "name": "2 - kurs"},
  ];
  Map course = {};
  void setCourse(course) {
    this.course = course;
    notifyListeners();
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
  }

  TeacherProvider();
}
