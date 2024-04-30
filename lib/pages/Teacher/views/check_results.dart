import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/pages/Teacher/widgets/custom_quiz_widget.dart';
import 'package:kiuf_quiz/providers/teacher/check_results_provider.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class CheckResults extends StatelessWidget {
  const CheckResults({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckResultsProvider>(
      create: (context) => CheckResultsProvider(),
      builder: (context, snapshot) {
        return Consumer<CheckResultsProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('check_results'.tr),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomDropdown(
                        data: provider.quizStudents,
                        hintText: "select_student".tr,
                        onChange: (one) async {
                          provider.setStudent(one);
                          provider.getStudentQuestions(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: provider.studentQuestions.isEmpty
                        ? Center(
                            child: Text("if_you_want_to_see_results_select_student".tr),
                          )
                        : ListView.builder(
                            itemCount: provider.studentQuestions.length,
                            itemBuilder: (context, index) {
                              var question = provider.studentQuestions[index];
                              return CustomQuizWidget(
                                index: index,
                                question: question,
                                onPressed: () async {
                                  // await provider.deleteQuestion(question['id'].toString()).then((value) {
                                  //   provider.init();
                                  // });
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
