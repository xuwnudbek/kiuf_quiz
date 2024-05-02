import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/providers/student/quiz_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:provider/provider.dart';

class QuizIndicator extends StatefulWidget {
  const QuizIndicator(
    this.index, {
    super.key,
  });

  final int index;

  @override
  State<QuizIndicator> createState() => _QuizIndicatorState();
}

class _QuizIndicatorState extends State<QuizIndicator> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      var question = provider.questions[widget.index];
      bool selected = provider.checkQuestionSelection(question['id']);
      bool isActive = provider.tabController.index == widget.index;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: MouseRegion(
          onEnter: (_) {
            setState(() => isHover = true);
          },
          onExit: (_) {
            setState(() => isHover = false);
          },
          child: GestureDetector(
            onTap: () {
              provider.animateTo(widget.index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.blue
                    : (isHover || selected)
                        ? RGB.primary
                        : RGB.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? Colors.blue : RGB.primary,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                "${widget.index + 1}",
                style: Get.textTheme.titleSmall!.copyWith(
                  color: isActive || (selected || isHover) ? RGB.white : RGB.primary,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
