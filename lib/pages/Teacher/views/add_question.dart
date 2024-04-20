import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/pages/Teacher/widgets/custom_question_widget.dart';
import 'package:kiuf_quiz/providers/teacher/question_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class AddQuestion extends StatelessWidget {
  const AddQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionProvider>(
      create: (ctx) => QuestionProvider(),
      builder: (context, snapshot) {
        return Consumer<QuestionProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              backgroundColor: RGB.blueLight,
              appBar: AppBar(
                foregroundColor: RGB.white,
                title: Text('add_question'.tr),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (provider.isLoading) return;
                    Get.back(result: false);
                  },
                ),
              ),
              body: provider.isLoading
                  ? CustomLoadingWidget(
                      total: provider.questions.length,
                      count: provider.countOfCreatedQuestion,
                    )
                  : Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "tests".tr,
                                  children: const [
                                    TextSpan(
                                      text: "",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: Container(
                              width: Get.width * .65,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: provider.questions.isEmpty
                                        ? Center(
                                            child: Text(
                                              "no_questions".tr,
                                              style: TextStyle(color: RGB.black),
                                            ),
                                          )
                                        : ListView.builder(
                                            controller: provider.scrollController,
                                            itemCount: provider.questions.length,
                                            itemBuilder: (context, index) {
                                              return CustomQuestionWidget(index: index);
                                            },
                                          ),
                                  ),
                                  // const Spacer(),
                                  Row(
                                    children: [
                                      CustomButton(
                                        title: Row(
                                          children: [
                                            Icon(Ionicons.save, color: RGB.white, size: 20),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              "save".tr,
                                              style: TextStyle(color: RGB.white),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          provider.saveQuestions();
                                        },
                                      ),
                                      const Spacer(),
                                      CustomButton(
                                        title: Row(
                                          children: [
                                            Icon(Ionicons.add, color: RGB.white, size: 20),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              "add_question".tr,
                                              style: TextStyle(color: RGB.white),
                                            ),
                                          ],
                                        ),
                                        bgColor: RGB.warning,
                                        onPressed: () {
                                          provider.addNewQuestion(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
