import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  var userId = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;
  Future<void> login() async {
    isLoading = true;
    notifyListeners();

    log('User ID: ${userId.text}');
    log('Password: ${password.text}');

    Map<String, String> body = {
      "loginId": userId.text,
      "password": password.text,
    };

    var res = await HttpServise.POST(
      URL.teacherLogin,
      body: body,
    );

    if (res.status == HttpResponses.success) {
      Storage.setUser(res.data['user']);
      Storage.setToken(res.data['token']);

      Get.offAndToNamed("/teacher");
    }

    isLoading = false;
    notifyListeners();

    // Get.offAndToNamed("/teacher");
  }
}
