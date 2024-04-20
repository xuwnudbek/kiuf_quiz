import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:kiuf_quiz/utils/widgets/main_card.dart';
import 'package:provider/provider.dart';
import 'package:kiuf_quiz/providers/teacher/teacher_provider.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherProvider>(
      create: (ctx) => TeacherProvider(),
      builder: (context, snapshot) {
        return Consumer<TeacherProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Teacher'),
              shadowColor: RGB.primary,
              backgroundColor: RGB.primary,
              actions: [
                Text(
                  '${Storage.user['name']}',
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
                          Storage.clear();
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
            body: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      //Subjects
                      CustomDropdown(
                        data: provider.subjects,
                        hintText: "select_subject".tr,
                        onChange: (one) {
                          provider.setSubject(one);
                        },
                      ),
                      const SizedBox(width: 12.0),
                      //Departments
                      CustomDropdown(
                        data: provider.departments,
                        hintText: "select_department".tr,
                        onChange: (one) {
                          provider.setDepartment(one);
                        },
                      ),
                      const SizedBox(width: 12.0),
                      //Courses
                      CustomDropdown(
                        data: provider.courses,
                        hintText: "select_course".tr,
                        onChange: (one) {
                          provider.setCourse(one);
                        },
                      ),
                      const SizedBox(width: 12.0),
                      CustomDropdown(
                        data: provider.statuses,
                        hintText: "select_status".tr,
                        onChange: (one) {
                          provider.setStatus(one);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      //ClearButton
                      CustomButton(
                        splashColor: RGB.primaryLight,
                        title: Icon(
                          Ionicons.reload,
                          color: RGB.white,
                          weight: 2,
                          size: 22,
                        ),
                        bgColor: RGB.primary,
                        onPressed: () {
                          provider.clear();
                        },
                      ),
                      const Spacer(),
                      CustomButton(
                        title: Text("add_quiz".tr),
                        bgColor: RGB.primary,
                        onPressed: () async {
                          var res = await Get.toNamed("/add-quiz");
                          print(res);
                          if (res == true) {
                            provider.init();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: provider.isLoading
                        ?  Center(
                            child: CustomLoadingWidget(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  mainAxisExtent: 400.0,
                                ),
                                itemCount: provider.filteredQuizzes.length,
                                itemBuilder: (context, index) {
                                  var quiz = provider.filteredQuizzes[index];
                                  return MainCard(quiz, index: index);
                                },
                              ),
                            ),
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
