import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/providers/student/student_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:provider/provider.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentProvider>(
      create: (ctx) => StudentProvider(),
      builder: (context, snapshot) {
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
            ],
          ),
          body: const Center(
            child: Text("Student"),
          ),
        );
      },
    );
  }
}
