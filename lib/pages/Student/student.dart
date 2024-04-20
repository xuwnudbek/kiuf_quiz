import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/pages/Student/widgets/subject_card.dart';
import 'package:kiuf_quiz/providers/student/student_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_input.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentProvider>(
      create: (ctx) => StudentProvider(),
      builder: (context, snapshot) {
        return Consumer<StudentProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Student'),
              backgroundColor: RGB.primary,
              actions: [
                Text(
                  'Xushnudbek\nAbdusamatov',
                  textAlign: TextAlign.right,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: RGB.white,
                  ),
                ),
                const SizedBox(width: 8.0),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  position: PopupMenuPosition.under,
                  color: RGB.white,
                  iconColor: RGB.white,
                  icon: CircleAvatar(
                    backgroundColor: RGB.white,
                    child: const Icon(Icons.person_rounded),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: "logout",
                        onTap: () {
                          Get.offAllNamed("/auth");
                        },
                        child: const Row(
                          children: [
                            Icon(Ionicons.log_out_outline),
                            SizedBox(width: 8.0),
                            Text("Profile"),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            body: Center(
              child: provider.isLoading
                  ?  CustomLoadingWidget()
                  : provider.subjects.isEmpty
                      ? Text("no_any_subject".tr)
                      : Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "subjects".tr,
                                  style: const TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: Get.width * .8,
                                minWidth: 800,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: provider.subjects.length,
                                itemBuilder: (context, index) {
                                  var subject = provider.subjects[index];
                                  return SubjectCard(
                                    subject,
                                    onPressed: () async {
                                      provider.quizIdController.clear();
                                      var res = await Get.defaultDialog(
                                        title: "",
                                        titleStyle: const TextStyle(fontSize: 0),
                                        barrierDismissible: false,
                                        backgroundColor: RGB.white,
                                        radius: 10.0,
                                        contentPadding: const EdgeInsets.only(
                                          left: 24.0,
                                          top: 12.0,
                                          bottom: 16.0,
                                          right: 24.0,
                                        ),
                                        content: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "enter_quiz_id".tr,
                                                  style: Get.textTheme.bodyMedium!.copyWith(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    color: RGB.primary.withOpacity(.2),
                                                  ),
                                                  child: Text(
                                                    "${subject['name']} 88948979797889 9848498",
                                                    style: Get.textTheme.bodyMedium!.copyWith(
                                                      overflow: TextOverflow.clip,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: RGB.black.withAlpha(150),
                                                    ),
                                                    maxLines: 1,
                                                  ).paddingSymmetric(horizontal: 8.0, vertical: 4.0),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            CustomInput(
                                              controller: provider.quizIdController,
                                              formatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(10),
                                              ],
                                              style: const TextStyle(
                                                letterSpacing: 6.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          CustomButton(
                                            title: Text("start_quiz".tr),
                                            bgColor: RGB.primary,
                                            onPressed: () {
                                              if (provider.quizIdController.text.isEmpty || provider.quizIdController.text.length != 10) {
                                                CustomSnackbars.error(context, "must_fill_quiz_id".tr);
                                                return;
                                              }
                                              Get.back(result: true);
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "cancel".tr,
                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                color: RGB.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                      if (res == null) return;
                                      // start quiz
                                      provider.startQuiz(
                                        provider.quizIdController.text,
                                        subject["id"],
                                      );
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
