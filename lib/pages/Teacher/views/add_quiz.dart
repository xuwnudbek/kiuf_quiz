import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/providers/teacher/quiz_provider.dart';
import 'package:kiuf_quiz/utils/extensions/datetime.dart';
import 'package:kiuf_quiz/utils/extensions/time_of_day.dart';
import 'package:kiuf_quiz/utils/functions/show_datetime_with_time_range.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:kiuf_quiz/utils/widgets/widget_theme.dart';
import 'package:provider/provider.dart';

class AddQuiz extends StatelessWidget {
  const AddQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizProvider>(
      create: (ctx) => QuizProvider(),
      builder: (context, snapshot) {
        return Consumer<QuizProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: RGB.white,
                title: Text('add_quiz'.tr),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: Center(
                child: provider.isLoading
                    ? CustomLoadingWidget()
                    : Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: RGB.blueLight,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: WidgetThemes.mainShadow,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'add_quiz'.tr,
                              style: Get.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              data: provider.departments,
                              fillColor: RGB.white,
                              // hintText: 'select_department'.tr,
                              onChange: (value) {
                                provider.setDepartment(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: provider.courses,
                              hintText: 'select_course'.tr,
                              onChange: (value) {
                                provider.setCourse(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: provider.types,
                              hintText: 'select_type'.tr,
                              onChange: (value) {
                                provider.setType(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            CustomDropdown(
                              size: const Size(double.infinity, 50.0),
                              fillColor: RGB.white,
                              data: provider.subjects,
                              hintText: 'select_subject'.tr,
                              onChange: (value) {
                                provider.setSubject(value);
                              },
                            ),
                            const SizedBox(height: 8.0),
                            //Date picker
                            CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.dateWithTime == null ? 'choose_quiz_day'.tr : "${provider.dateWithTime?.day.toFormattedString()} | ${provider.dateWithTime?.from.toFormattedString()} - ${provider.dateWithTime?.to.toFormattedString()}",
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
                                  provider.setDateWithTime(res);
                                }
                              },
                            ),
                            const SizedBox(height: 16.0),
                            //Start time picker
                            CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  provider.isCreating
                                      ? SizedBox.square(
                                          dimension: 23,
                                          child: CircularProgressIndicator(
                                            color: RGB.white,
                                            strokeWidth: 1.5,
                                          ),
                                        )
                                      : Text("add".tr),
                                ],
                              ),
                              bgColor: RGB.primary,
                              onPressed: () {
                                if (provider.isCreating) return;
                                provider.createQuiz();
                              },
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
