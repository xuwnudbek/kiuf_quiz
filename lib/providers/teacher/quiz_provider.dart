import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/extensions/datetime.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/extensions/time_of_day.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class QuizProvider extends ChangeNotifier {
  List departments = [];
  Map department = {}; //dep_id
  void setDepartment(Map dep) {
    department = dep;
    notifyListeners();
  }

  List courses = [];
  Map course = {}; //course_id
  void setCourse(Map crs) {
    course = crs;
    notifyListeners();
  }

  List types = [
    {"id": 0, "name": "Oraliq"},
    {"id": 1, "name": "Yakuniy"}
  ];
  Map type = {}; //0 - open, 1 - closed
  void setType(Map tp) {
    type = tp;
    notifyListeners();
  }

  List subjects = [];
  Map subject = {}; //subject_id
  void setSubject(Map sbj) {
    subject = sbj;
    notifyListeners();
  }

  DateWithTime? dateWithTime;
  void setDateWithTime(DateWithTime dt) {
    dateWithTime = dt;
    notifyListeners();
  }

  bool isCreating = false;

  QuizProvider({bool hasInit = false}) {
    init(hasInit: hasInit);
  }

  bool isLoading = false;
  Future init({required bool hasInit}) async {
    isLoading = true;
    notifyListeners();

    await getTeacherSubjects();
    await getTeacherDepartments();
    await getTeacherCourses();

    if (hasInit) {
      await hasInitValues();
    }

    isLoading = false;
    notifyListeners();
  }

  Future hasInitValues() async {
    Map quiz = {};
    var res = await HttpServise.GET("${URL.quiz}/${Storage.quizId}");

    if (res.status == HttpResponses.success) {
      quiz = res.data;
    }

    setDepartment(departments.firstWhereOrNull((element) => element['name'] == quiz['department']));
    setCourse(courses.firstWhereOrNull((element) => element['name'].toString().contains(quiz['course'])));
    setType(types.firstWhereOrNull((element) => element['id'] == quiz['type']));
    setSubject(subjects.firstWhereOrNull((element) => element['name'] == quiz['subject']));
    setDateWithTime(DateWithTime(
      quiz['start_time'].toString().toDateTime,
      TimeOfDay(
        hour: quiz['start_time'].toString().split(" ").last.split(":")[0].toInt,
        minute: quiz['start_time'].toString().split(" ").last.split(":")[1].toInt,
      ),
      TimeOfDay(
        hour: quiz['end_time'].toString().split(" ").last.split(":")[0].toInt,
        minute: quiz['end_time'].toString().split(" ").last.split(":")[1].toInt,
      ),
    ));
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

  bool isUpdating = false;
  //Update The Quiz
  Future updateQuiz(ctx, {id}) async {
    isUpdating = true;
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
      "${URL.teacherQuizUpdate}/$id",
      body: body,
    );
    if (res.status == HttpResponses.success) {
      CustomSnackbars.success(ctx, "quiz_successfully_updated".tr);
    }
    // log("${res.data}");

    isUpdating = false;
    notifyListeners();
  }
}
