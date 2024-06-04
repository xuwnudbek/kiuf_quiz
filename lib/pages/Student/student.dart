import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/pages/Student/widgets/quiz_card.dart';
import 'package:kiuf_quiz/providers/student/student_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_loading_widget.dart';
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
              title: Text('Student', style: TextStyle(color: RGB.white)),
              foregroundColor: RGB.white,
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
                  elevation: 5.0,
                  surfaceTintColor: RGB.white,
                  constraints: const BoxConstraints(
                    maxWidth: 150,
                    minWidth: 150,
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
                            Icon(Ionicons.log_out_outline, color: Colors.red),
                            SizedBox(width: 8.0),
                            Text(
                              "Profile",
                              style: TextStyle(color: Colors.red),
                            ),
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
                  ? CustomLoadingWidget()
                  : provider.studentQuizzes.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("no_any_quizzes".tr),
                            const SizedBox(height: 16.0),
                            IconButton(
                              onPressed: () {
                                provider.getQuizzes();
                              },
                              icon: const Icon(Icons.refresh_rounded, size: 28),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "quizzes".tr,
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
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 2,
                                ),
                                itemCount: provider.studentQuizzes.length,
                                itemBuilder: (context, index) {
                                  var quiz = provider.studentQuizzes[index];
                                  return QuizCard(
                                    quiz: quiz,
                                    onPressed: () async {
                                      provider.startQuiz(quiz);
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
