import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                          AppBar(
                            backgroundColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            centerTitle: true,
                            leading: const SizedBox.shrink(),
                            title: Text(
                              "tests".tr,
                              style: TextStyle(
                                fontSize: 36,
                                color: RGB.primary,
                              ),
                            ),
                            actions: [
                              CustomButton(
                                title: Row(
                                  children: [
                                    Icon(
                                      Ionicons.save,
                                      color: RGB.white,
                                      size: 20,
                                    ),
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
                              const SizedBox(width: 24.0),
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
                                              return Column(
                                                children: [
                                                  CustomQuestionWidget(
                                                    index: index,
                                                    isLast: index == provider.questions.length - 1,
                                                  ),
                                                  Visibility(
                                                    visible: index < provider.questions.length - 1,
                                                    child: const Divider(thickness: 2),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${"total_score_for_open_questions".tr}:",
                                          ),
                                          const SizedBox(width: 8.0),
                                          DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: RGB.white,
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                            child: SizedBox(
                                              width: 80,
                                              height: 40,
                                              child: TextFormField(
                                                controller: provider.totalScoreController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  LengthLimitingTextInputFormatter(3),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "score".tr,
                                                  hintStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: RGB.grey.withAlpha(150),
                                                  ),
                                                  fillColor: Colors.amber,
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          SizedBox(
                                            width: 39,
                                            height: 39,
                                            child: TextButton(
                                              onPressed: () {
                                                provider.setTotalScore();
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                iconColor: Colors.green,
                                                backgroundColor: Colors.green.withAlpha(75),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.check_rounded,
                                              ),
                                            ),
                                          ),
                                        ],
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
