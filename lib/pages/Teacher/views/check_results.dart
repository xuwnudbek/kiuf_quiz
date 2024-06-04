// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/pages/Teacher/widgets/student_tile.dart';
import 'package:kiuf_quiz/providers/teacher/check_results_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:kiuf_quiz/utils/widgets/svg.dart';
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
                title: Text('check_results'.tr, style: TextStyle(color: RGB.white)),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.offAllNamed('/teacher');
                  },
                ),
                actionsIconTheme: IconThemeData(color: RGB.white),
                actions: const [
                  SizedBox(width: 16),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(32.0),
                child: provider.isLoading
                    ? CustomLoadingWidget()
                    : provider.quizStudents.isEmpty
                        ? Center(
                            child: Text(
                              "not_found_any_data".tr,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: RGB.blueLight,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "students".tr,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: RGB.primary,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12.0),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: provider.quizStudents.length,
                                        itemBuilder: (context, index) {
                                          var student = provider.quizStudents[index];
                                          bool selected = student == provider.student;
                                          return StudentTile(
                                            student: student,
                                            selected: selected,
                                          );
                                        },
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          IconButton(
                                            color: RGB.grey,
                                            tooltip: "Download all students results as Excel",
                                            onPressed: () {
                                              // provider.exportAllStudentToExcel();
                                            },
                                            icon: const SVG("excel"),
                                          ),
                                          const SizedBox(width: 16),
                                          IconButton(
                                            color: RGB.grey,
                                            onPressed: () {
                                              provider.exportAllStudentToPdf(context);
                                            },
                                            tooltip: "Download all students results as PDF",
                                            icon: const SVG(
                                              "pdf",
                                              size: 28,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                flex: 10,
                                child: provider.isSearching || provider.isUpdating
                                    ? CustomLoadingWidget()
                                    : provider.student.isEmpty
                                        ? Center(
                                            child: Text("if_you_want_to_see_results_select_student".tr),
                                          )
                                        : provider.studentQuestions.isEmpty
                                            ? Center(
                                                child: Text("not_found_any_data".tr),
                                              )
                                            : Column(
                                                children: [
                                                  AppBar(
                                                    backgroundColor: Colors.transparent,
                                                    surfaceTintColor: Colors.transparent,
                                                    leading: const SizedBox.shrink(),
                                                    centerTitle: true,
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
                                                        bgColor: provider.closeQuestionsScores.isEmpty ? RGB.grey : RGB.primary,
                                                        onPressed: () {
                                                          if (provider.closeQuestionsScores.isEmpty) return;
                                                          provider.saveQuestions();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: provider.studentQuestions.length,
                                                      itemBuilder: (context, index) {
                                                        return StudentQuestionWidget(index: index);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                              ),
                            ],
                          ),
              ),
              floatingActionButton: provider.student.isEmpty || provider.studentQuestions.isEmpty
                  ? null
                  : FloatingActionButton(
                      backgroundColor: RGB.primary,
                      onPressed: () {
                        provider.downloadStudentResultsAsPDF(context);
                      },
                      tooltip: "Download student results as PDF",
                      child: Icon(
                        Icons.download_rounded,
                        color: RGB.white,
                      ),
                    ));
        });
      },
    );
  }
}

class StudentQuestionWidget extends StatelessWidget {
  StudentQuestionWidget({
    super.key,
    required this.index,
  });

  final int index;

  var studentQuestionData;
  var question;
  var studentAnswer;
  var isOpen;
  var isTrue;
  dynamic questionAnswer;

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckResultsProvider>(builder: (context, provider, _) {
      studentQuestionData = provider.studentQuestions[index];
      question = studentQuestionData['question'];
      isOpen = question['is_close'] == 0 ? true : false;

      if (isOpen) {
        questionAnswer = (question['answers'] as List).firstWhere(
          (element) => element['is_true'] == 1,
          orElse: () => {},
        );
      } else {
        questionAnswer = studentQuestionData['answer'];
      }

      if (isOpen) {
        studentAnswer = ((question['answers'] ?? []) as List).firstWhere((element) => element['id'] == studentQuestionData['answer_id'], orElse: () => {});
        isTrue = studentAnswer['is_true'] == 1 ? true : false;
      } else {
        studentAnswer = studentQuestionData['answer'] ?? "";
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(text: "${index + 1}. ", children: [
                    TextSpan(
                      text: "${question['question']}",
                      style: Get.textTheme.titleMedium,
                    ),
                  ]),
                  style: Get.textTheme.titleLarge,
                  selectionColor: Colors.orange,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              isOpen
                  ? Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: 60,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: isTrue ? Colors.green.withAlpha(75) : Colors.red.withAlpha(75),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${studentAnswer['answer']}",
                            style: Get.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: isTrue ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  "${question['score']} ${'score'.tr}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).paddingSymmetric(horizontal: 8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: 60,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: RGB.blueLight,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${studentAnswer.isEmpty ? "answer_not_written".tr : studentAnswer}",
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: RGB.black.withAlpha(studentAnswer.isEmpty ? 100 : 255),
                            ),
                          ),
                          Visibility(
                            visible: studentAnswer.isNotEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // input score
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: RGB.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    width: 80,
                                    height: 30,
                                    child: TextFormField(
                                      controller: provider.closeQuestionsScores[question['id']],
                                      onChanged: (value) {
                                        provider.calculateCloseQuestionsScore();
                                      },
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ).marginOnly(bottom: 30);
    });
  }
}
