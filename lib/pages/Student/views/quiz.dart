import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                title: Text('quiz'.tr, style: TextStyle(color: RGB.white)),
                foregroundColor: RGB.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: RGB.white,
                  ),
                  onPressed: () async {
                    var res = await provider.quit();
                    if (res == true) {
                      Get.back();
                    }
                  },
                ),
              ),
              body: Center(
                child: provider.isSaving
                    ? CustomLoadingWidget(
                        total: provider.answers.length,
                        count: provider.statuses.length,
                      )
                    : provider.isLoading
                        ? CustomLoadingWidget()
                        : provider.questions.isEmpty
                            ? Center(
                                child: Text("there_is_no_any_question".tr),
                              )
                            : Container(
                                constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.9,
                                  maxHeight: Get.height * 0.9,
                                ),
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  children: [
                                    AppBar(
                                      backgroundColor: RGB.white,
                                      centerTitle: true,
                                      title: Text(
                                        provider.timer,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey,
                                        ),
                                      ),
                                      actions: [
                                        CustomButton(
                                          title: Text("finish_quiz".tr),
                                          onPressed: () async {
                                            var res = await provider.finish();
                                            if (res == true) {
                                              Get.back(result: true);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                //StudentQuestionWidget
                                                StudentQuestionWidget(
                                                  index: provider.tabController.index,
                                                ),
                                                //Spacer beetween StudentQuestionWidget and bottom Buttons
                                                const Spacer(),
                                                //bottom Buttons
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    CustomButton(
                                                      title: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_left,
                                                            color: provider.tabController.index == 0 ? RGB.grey : RGB.primary,
                                                          ),
                                                          Text(
                                                            "prev".tr,
                                                            style: TextStyle(
                                                              color: provider.tabController.index == 0 ? RGB.grey : RGB.primary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        provider.goToPrev();
                                                      },
                                                      bgColor: RGB.white,
                                                      outlinedBorder: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        side: BorderSide(
                                                          color: provider.tabController.index == 0 ? RGB.grey : RGB.primary,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    CustomButton(
                                                      title: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "next".tr,
                                                            style: TextStyle(
                                                              color: provider.tabController.index == provider.questions.length - 1 ? RGB.grey : RGB.primary,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: provider.tabController.index == provider.questions.length - 1 ? RGB.grey : RGB.primary,
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        provider.goToNext();
                                                      },
                                                      bgColor: RGB.white,
                                                      outlinedBorder: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        side: BorderSide(
                                                          color: provider.tabController.index == provider.questions.length - 1 ? RGB.grey : RGB.primary,
                                                          width: 2,
                                                        ),
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
