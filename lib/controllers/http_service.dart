// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kiuf_quiz/controllers/storage_service.dart';

class URL {
  static String domain = '172.16.91.50:8000';

  static String additional = "api";
  static String login = '$additional/login';
  static String teacher = '$additional/teacher';
  static String teacherQuizzes = '$teacher/quizzes';
  static String teacherSubjects = '$additional/subjects';
  static String teacherDepartments = '$additional/departments';
  static String teacherCourses = '$additional/courses';
  static String teacherQuizCreate = '$additional/quizze/create';
  static String teacherQuizUpdate = '$additional/quizze/update';
  static String quizStudents = '$additional/quiz/students';
  static String quiz = '$additional/quizze';
  static String questionCreate = '$additional/question/create';
  static String questionDelete = '$additional/question/delete';
  static String studentQuestions = '$additional/student/answer/show';
  static String studentQuizzes = '$additional/student/quizze';
  static String studentAnswers = '$additional/student/answer/create';
  static String studentAnswerUpdate = '$additional/student/answer/update';

  static String subjectsAndDepartments = 'getdata';

  static Map<String, String> headers = {"Content-Type": "application/json"};
}

class HttpServise {
  static Future<HttpResponse> GET(url, {param}) async {
    var headers = URL.headers
      ..addAllIf(
        Storage.hasData('token'),
        {"Authorization": "Bearer ${Storage.token}"},
      );

    HttpResponse response;
    try {
      Uri uri = Uri.http(URL.domain, url, param);
      var res = await http.get(uri, headers: headers);

      if (res.statusCode < 299) {
        response = HttpResponse(
          jsonDecode(res.body),
          HttpResponses.success,
        );
      } else {
        response = HttpResponse(
          res.body,
          HttpResponses.error,
        );
        log(res.body.toString());
      }
    } catch (e) {
      response = HttpResponse(
        "Error: $e",
        HttpResponses.noConnection,
      );
      log("$e");
    }

    return response;
  }

  static Future<HttpResponse> POST(url, {body, param}) async {
    var headers = URL.headers
      ..addAllIf(
        Storage.hasData('token'),
        {"Authorization": "Bearer ${Storage.token}"},
      );

    HttpResponse response;
    try {
      Uri uri = Uri.http(URL.domain, url, param);
      var res = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      if (res.statusCode < 299) {
        response = HttpResponse(
          jsonDecode(res.body),
          HttpResponses.success,
        );
      } else {
        response = HttpResponse(
          res.body,
          HttpResponses.error,
        );
        log(res.body.toString());
      }
    } catch (e) {
      response = HttpResponse(
        "Error: $e",
        HttpResponses.noConnection,
      );
    }

    return response;
  }
}

class HttpResponse {
  final dynamic data;
  final HttpResponses status;

  HttpResponse(this.data, this.status);
}

enum HttpResponses { success, noConnection, error }
