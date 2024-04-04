import 'package:flutter/material.dart';
import 'package:kiuf_quiz/pages/Auth/auth.dart';
import 'package:kiuf_quiz/pages/Splash/splash_page.dart';
import 'package:kiuf_quiz/pages/Student/student.dart';
import 'package:kiuf_quiz/pages/Teacher/teacher.dart';

class PageRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (ctx) => const SplashPage(),

    //Auth
    '/auth': (ctx) => const AuthPage(),

    //Teacher
    '/teacher': (ctx) => const TeacherPage(),

    //Student
    '/student': (ctx) => const StudentPage(),
  };
}
