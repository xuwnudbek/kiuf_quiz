import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/providers/teacher/quiz_provider.dart';
import 'package:kiuf_quiz/providers/teacher/show_quiz_provider.dart';
import 'package:kiuf_quiz/providers/teacher/teacher_provider.dart';
import 'package:kiuf_quiz/utils/extensions/datetime.dart';
import 'package:kiuf_quiz/utils/extensions/time_of_day.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:kiuf_quiz/utils/widgets/image.dart';
import 'package:provider/provider.dart';

class ShowQuiz extends StatelessWidget {
  const ShowQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => QuizProvider()),
        ChangeNotifierProvider(create: (ctx) => ShowQuizProvider()),
      ],
      builder: (context, snapshot) {
        return Consumer2<ShowQuizProvider, QuizProvider>(
          builder: (context, sProvider, qProvider, _) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: RGB.white,
                title: Text("${'show_quiz'.tr} : ${Storage.quizId}"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.offAndToNamed("/teacher");
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    //Edit QUIZ
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: RGB.blueLight,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'edit_quiz'.tr,
                              style: const TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              data: qProvider.departmentList,
                              fillColor: RGB.white,
                              // hintText: 'select_department'.tr,
                              onChange: (value) {
                                qProvider.setDepartment(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: qProvider.courseList,
                              hintText: 'select_course'.tr,
                              onChange: (value) {
                                qProvider.setCourse(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: qProvider.typeList,
                              hintText: 'select_type'.tr,
                              onChange: (value) {
                                qProvider.setType(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: qProvider.subjectList,
                              hintText: 'select_subject'.tr,
                              onChange: (value) {
                                qProvider.setSubject(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            //Date picker
                            CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    qProvider.dateWithTime == null ? 'choose_quiz_day'.tr : "${qProvider.dateWithTime?.day.toFormattedString()} | ${qProvider.dateWithTime?.from.toFormattedString()} - ${qProvider.dateWithTime?.to.toFormattedString()}",
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              bgColor: RGB.white,
                              onPressed: () async {
                                var res = await Get.to(
                                  () => const ShowDatetimeWithTimeRange(),
                                  transition: Transition.topLevel,
                                  duration: const Duration(milliseconds: 100),
                                );
                                if (res != null) {
                                  qProvider.setDateWithTime(res);
                                  log(res.toString());
                                } else {
                                  log('res is null');
                                }
                              },
                            ),
                            const SizedBox(height: 16.0),
                            //Start time picker
                            CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("edit".tr),
                                ],
                              ),
                              bgColor: RGB.primary,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 24.0),
                    ),
                    const SizedBox(width: 24.0),
                    // Show QUIZ's questions
                    Flexible(
                      flex: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                          // color: RGB.blueLight,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                        ),
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "tests".tr,
                                  style: const TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                padding: const EdgeInsets.only(bottom: 16.0),
                                itemBuilder: (ctx, index) {
                                  return CustomOpenQuizWidget(
                                    data: const {},
                                    index: ++index,
                                    isOpen: index < 7,
                                    hasUnderline: index == 1 ? false : true,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: RGB.primary,
                onPressed: () {},
                label: Row(
                  children: [
                    Icon(Ionicons.add, color: RGB.white),
                    const SizedBox(width: 8.0),
                    Text(
                      "add_new_test".tr,
                      style: Get.textTheme.titleSmall!.copyWith(
                        color: RGB.white,
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

class CustomOpenQuizWidget extends StatelessWidget {
  CustomOpenQuizWidget({
    required this.data,
    required this.isOpen,
    required this.hasUnderline,
    this.index = 0,
    super.key,
  });

  final Map data;
  int index;
  bool isOpen;
  bool hasUnderline;

  var alphabet = ["A", "B", "C", "D", "E", "F"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: RGB.blueLight,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.only(left: 20, bottom: 16.0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasUnderline ? const Divider() : const SizedBox.shrink(),
          const SizedBox(height: 16.0),
          SizedBox(
            child: Text.rich(
              TextSpan(text: "$index. ", children: [
                TextSpan(
                  text: "In publishing and design, Lorem ipsum In publishing and graphic design, Lorem ipsum In publishing and graphic design, Lorem ipsum",
                  style: Get.textTheme.titleMedium,
                ),
              ]),
              style: Get.textTheme.titleLarge,
              selectionColor: Colors.orange,
            ),
          ),

          //Answers
          !isOpen
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    const SizedBox(height: 16.0),
                    Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...[0, null, 1].map((index) {
                          if (index == null) return const SizedBox(width: 8.0);
                          return Flexible(
                            child: Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  baseline: TextBaseline.alphabetic,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        alphabet[index],
                                        style: Get.textTheme.titleMedium,
                                      ),
                                      SizedBox.square(
                                        dimension: 30,
                                        child: index.isEven ? null : const IMAGE("circle_mark_2.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: " In publishing and design, Lorem ipsum In publishing and graphic design, Lorem ipsum In publishing and graphic design, Lorem ipsum",
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ]),
                              style: Get.textTheme.titleMedium,
                              selectionColor: Colors.red,
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...[2, null, 3].map((index) {
                          if (index == null) return const SizedBox(width: 8.0);

                          return Flexible(
                            child: Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  baseline: TextBaseline.alphabetic,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        alphabet[index],
                                        style: Get.textTheme.titleMedium,
                                      ),
                                      SizedBox.square(
                                        dimension: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: " In publishing and design, Lorem ipsum In publishing and graphic design, Lorem ipsum In publishing and graphic design, Lorem ipsum",
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ]),
                              style: Get.textTheme.titleMedium,
                              selectionColor: Colors.red,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
