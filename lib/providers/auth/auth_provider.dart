import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

class AuthProvider extends ChangeNotifier {
  var userId = TextEditingController();
  var password = TextEditingController();

  bool isStudent = true;

  void toggleMode(value) {
    isStudent = value;
    notifyListeners();
  }

  AuthProvider() {
    Storage.remove("token");
    Storage.remove("user");
  }

  bool isLoading = false;
  Future<void> login(BuildContext ctx) async {
    isLoading = true;
    notifyListeners();

    Map<String, String> body = {
      "loginId": userId.text,
      "password": password.text,
    };

    var res = await HttpServise.POST(
      URL.login,
      body: body,
    );

    if (res.status == HttpResponses.success) {
      Storage.setUser(res.data['user']);
      Storage.setToken(res.data['token']);

      if (res.data['user']['loginId'].toString().length == 8 || res.data['user']['course'] == null) {
        Get.offAllNamed("/teacher");
      } else {
        Get.offAllNamed("/student");
      }
    } else {
      CustomSnackbars.error(ctx, res.data['error'].toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
