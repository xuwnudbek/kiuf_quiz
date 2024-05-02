import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/http_service.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class StudentProvider extends ChangeNotifier {
  TextEditingController quizIdController = TextEditingController();

  List studentQuizzes = [];

  Map subject = {};
  void setSubject(Map subject) {
    this.subject = subject;
    notifyListeners();
  }

  StudentProvider() {
    getQuizzes();
  }

  void startQuiz(Map quiz) async {
    var res = await Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 175,
          decoration: BoxDecoration(
            color: RGB.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "really_want_to_start_this_quiz".tr,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text("no".tr),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: RGB.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: Text("yes".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));

    if (res == true) {
      Storage.setQuizId(quiz['id']);
      var res = await Get.toNamed("/quiz");
      if (res == true) {
        getQuizzes();
      }
    }
  }

  bool isLoading = false;
  Future getQuizzes() async {
    isLoading = true;
    notifyListeners();

    var res = await HttpServise.GET(URL.studentQuizzes);

    if (res.status == HttpResponses.success) {
      studentQuizzes = res.data;
    }

    isLoading = false;
    notifyListeners();
  }
}
