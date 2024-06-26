import 'package:flutter/material.dart';
import 'package:kiuf_quiz/pages/Auth/auth.dart';
import 'package:kiuf_quiz/pages/Splash/splash_page.dart';
import 'package:kiuf_quiz/pages/Student/student.dart';
import 'package:kiuf_quiz/pages/Student/views/quiz.dart';
import 'package:kiuf_quiz/pages/Teacher/teacher.dart';
import 'package:kiuf_quiz/pages/Teacher/views/add_question.dart';
import 'package:kiuf_quiz/pages/Teacher/views/add_quiz.dart';
import 'package:kiuf_quiz/pages/Teacher/views/check_results.dart';
import 'package:kiuf_quiz/pages/Teacher/views/show_quiz.dart';

class PageRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (ctx) => const SplashPage(),

    //Auth
    '/auth': (ctx) => const AuthPage(),

    //Teacher
    '/teacher': (ctx) => const TeacherPage(),
    '/show-quiz': (ctx) => const ShowQuiz(),
    '/add-quiz': (ctx) => const AddQuiz(),
    '/add-question': (ctx) => const AddQuestion(),
    '/check-results': (ctx) => const CheckResults(),

    //Student
    '/student': (ctx) => const StudentPage(),
    '/quiz': (ctx) => const QuizPage(),
  };
}
