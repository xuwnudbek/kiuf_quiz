import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';

class ShowQuizProvider extends ChangeNotifier {
  ShowQuizProvider() {
    initialize();
  }

  void initialize() async {
    if (Storage.quizId == null) {
      Get.back();
    }
  }

  @override
  void dispose() {
    Storage.remove("quiz_id");
    super.dispose();
  }
}
