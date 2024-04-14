import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_dropdown.dart';
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
                          Get.offAndToNamed("/auth");
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
                IconButton(
                  icon: Icon(Ionicons.airplane_outline, color: RGB.blueLight),
                  onPressed: () {
                    Get.offAndToNamed("/sadasd");
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
                        onChange: (one) {},
                      ),
                      const SizedBox(width: 12.0),
                      //Departments
                      CustomDropdown(
                        data: provider.departments,
                        hintText: "select_department".tr,
                        onChange: (one) {},
                      ),
                      const SizedBox(width: 12.0),
                      //Courses
                      CustomDropdown(
                        data: provider.courses,
                        hintText: "select_course".tr,
                        onChange: (one) {},
                      ),
                      const SizedBox(width: 12.0),
                      CustomDropdown(
                        data: provider.statuses,
                        hintText: "select_status".tr,
                        onChange: (one) {},
                      ),
                      const Spacer(),
                      CustomButton(
                        title: Text("add_quiz".tr),
                        bgColor: RGB.primary,
                        onPressed: () {
                          Get.toNamed("/add-quiz");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: Padding(
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
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return MainCard({"id": index});
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
