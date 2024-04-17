import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthProvider extends ChangeNotifier {
  var userId = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;
  Future<void> login() async {
    isLoading = true;
    notifyListeners();

    log('User ID: ${userId.text}');
    log('Password: ${password.text}');
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();

    Get.offAndToNamed("/teacher");
  }
}
