// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kiuf_quiz/controllers/storage_service.dart';

class URL {
  static String domain = '192.168.52.50:8000';

  static String additional = "api";
  static String teacher = '$additional/teacher';
  static String teacherLogin = '$teacher/login';
  static String teacherQuizzes = '$teacher/quizzes';
  static String teacherSubjects = '$additional/subjects';
  static String teacherDepartments = '$additional/departments';
  static String teacherCourses = '$additional/courses';
  static String teacherQuizCreate = '$additional/quizze/create';
  static String quiz = '$additional/quizze';
  static String questionCreate = '$additional/question/create';
  static String questionDelete = '$additional/question/delete';

  static String subjectsAndDepartments = 'getdata';

  static Map<String, String> headers = {"Content-Type": "application/json"};
}

class HttpServise {
  static Future<HttpResponse> GET(url, {param}) async {
    var headers = URL.headers
      ..addAll(
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
      }
    } catch (e) {
      response = HttpResponse(
        "Error: $e",
        HttpResponses.noConnection,
      );
    }

    return response;
  }

  static Future<HttpResponse> POST(url, {body, param}) async {
    var headers = URL.headers
      ..addAll(
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
