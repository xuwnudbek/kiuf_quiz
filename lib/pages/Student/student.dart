import 'package:flutter/material.dart';
import 'package:kiuf_quiz/providers/student_provider.dart';
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
            title: const Text(''),
          ),
          body: const Center(
            child: Text("Student"),
          ),
        );
      },
    );
  }
}
