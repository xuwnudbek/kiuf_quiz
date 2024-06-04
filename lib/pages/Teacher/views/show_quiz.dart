import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/pages/Teacher/widgets/custom_quiz_widget.dart';
import 'package:kiuf_quiz/providers/teacher/quiz_provider.dart';
import 'package:kiuf_quiz/providers/teacher/show_quiz_provider.dart';
import 'package:kiuf_quiz/utils/extensions/datetime.dart';
import 'package:kiuf_quiz/utils/extensions/time_of_day.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class ShowQuiz extends StatelessWidget {
  const ShowQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => QuizProvider(hasInit: true)),
        ChangeNotifierProvider(create: (ctx) => ShowQuizProvider()),
      ],
      builder: (context, snapshot) {
        return Consumer2<ShowQuizProvider, QuizProvider>(
          builder: (context, sProvider, qProvider, _) {
            return Scaffold(
                appBar: AppBar(
                  foregroundColor: RGB.white,
                  title: Text('show_quiz'.tr, style: TextStyle(color: RGB.white)),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back(result: false);
                    },
                  ),
                ),
                body: sProvider.isLoading || qProvider.isLoading
                    ? Center(
                        child: CustomLoadingWidget(),
                      )
                    : Padding(
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
                                      data: qProvider.departments,
                                      fillColor: RGB.white,
                                      hintText: 'select_department'.tr,
                                      initialValue: qProvider.department,
                                      onChange: (value) {
                                        qProvider.setDepartment(value);
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    CustomDropdown(
                                      size: const Size(double.infinity, 50.0),
                                      fillColor: RGB.white,
                                      data: qProvider.courses,
                                      hintText: 'select_course'.tr,
                                      initialValue: qProvider.course,
                                      onChange: (value) {
                                        qProvider.setCourse(value);
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    CustomDropdown(
                                      size: const Size(double.infinity, 50.0),
                                      fillColor: RGB.white,
                                      data: qProvider.types,
                                      hintText: 'select_type'.tr,
                                      initialValue: qProvider.type,
                                      onChange: (value) {
                                        qProvider.setType(value);
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    CustomDropdown(
                                      size: const Size(double.infinity, 50.0),
                                      fillColor: RGB.white,
                                      data: qProvider.subjects,
                                      hintText: 'select_subject'.tr,
                                      initialValue: qProvider.subject,
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
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    //Start time picker
                                    CustomButton(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          qProvider.isUpdating
                                              ? SizedBox.square(
                                                  dimension: 20,
                                                  child: CircularProgressIndicator(
                                                    color: RGB.white,
                                                  ),
                                                )
                                              : Text("edit".tr),
                                        ],
                                      ),
                                      bgColor: RGB.primary,
                                      onPressed: () {
                                        qProvider.updateQuiz(context, id: Storage.quizId);
                                      },
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
                                          style: const TextStyle(fontSize: 36),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    Expanded(
                                      child: sProvider.questions.isEmpty
                                          ? Center(
                                              child: Text(
                                                "no_tests".tr,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: RGB.grey,
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: sProvider.questions.length,
                                              padding: const EdgeInsets.only(bottom: 16.0),
                                              itemBuilder: (ctx, index) {
                                                var question = sProvider.questions[index];
                                                return CustomQuizWidget(
                                                  index: index,
                                                  question: question,
                                                  onPressed: () async {
                                                    await sProvider.deleteQuestion(question['id'].toString()).then((value) {
                                                      sProvider.init();
                                                    });
                                                  },
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
                floatingActionButton: sProvider.isLoading || qProvider.isLoading
                    ? const SizedBox.shrink()
                    : FloatingActionButton.extended(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: RGB.primary,
                        onPressed: () async {
                          var res = await Get.toNamed("/add-question");
                          if (res == true) {
                            sProvider.init();
                          }
                        },
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
                      ));
          },
        );
      },
    );
  }
}
