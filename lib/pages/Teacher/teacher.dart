import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kiuf_quiz/providers/teacher_provider.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeacherProvider>(
      create: (ctx) => TeacherProvider(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: const Center(
            child: Text("Teacher"),
          ),
        );
      },
    );
  }
}
