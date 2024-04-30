import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/pages/Student/widgets/quiz_indicator.dart';
import 'package:kiuf_quiz/pages/Student/widgets/student_question_widget.dart';
import 'package:kiuf_quiz/providers/student/quiz_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizProvider>(
      create: (ctx) => QuizProvider(this, context),
      builder: (context, snapshot) {
        return Consumer<QuizProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                title: Text('quiz'.tr),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: RGB.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: Center(
                child: provider.isLoading
                    ? CustomLoadingWidget()
                    : provider.questions.isEmpty
                        ? Center(
                            child: Text("there_is_no_any_question".tr),
                          )
                        : Container(
                            constraints: BoxConstraints(
                              maxWidth: Get.width * 0.9,
                              maxHeight: Get.height * 0.8,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 6,
                                    ),
                                    itemCount: provider.questions.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return QuizIndicator(index);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 36),

                                      StudentQuestionWidget(
                                        question: const {},
                                        index: provider.tabController.index,
                                        isOpen: Random().nextBool(),
                                      ),

                                      const Spacer(),
                                      // Buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomButton(
                                            onPressed: () {
                                              provider.goToPrev();
                                            },
                                            title: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Ionicons.arrow_back),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'prev'.tr,
                                                  style: const TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CustomButton(
                                            onPressed: () {
                                              provider.goToNext();
                                            },
                                            title: Row(
                                              children: [
                                                Text(
                                                  'next'.tr,
                                                  style: const TextStyle(fontSize: 15),
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(Ionicons.arrow_forward),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
            );
          },
        );
      },
    );
  }
}
