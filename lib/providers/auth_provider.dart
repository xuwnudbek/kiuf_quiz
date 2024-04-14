import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  var userId = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;
  Future<void> login() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    print('User ID: ${userId.text}');
    print('Password: ${password.text}');

    isLoading = false;
    notifyListeners();

    // Get.offAndToNamed("/teacher");
  }
}
