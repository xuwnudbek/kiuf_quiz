import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/providers/student/quiz_provider.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class StudentQuestionWidget extends StatelessWidget {
  const StudentQuestionWidget({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      var question = provider.questions.elementAt(provider.tabController.index);
      List answers = question['answers'];
      bool isOpen = question['is_close'] == 0;

      return SizedBox(
        width: Get.width * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(text: "${index + 1}. ", children: [
                TextSpan(
                  text: "${question['question']}",
                  style: Get.textTheme.titleMedium,
                ),
              ]),
              style: Get.textTheme.titleLarge,
              selectionColor: Colors.orange,
            ),
            const SizedBox(height: 32.0),
            !isOpen
                ? CustomInput(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: provider.answers[question['id']] ?? "",
                        selection: TextSelection.collapsed(offset: provider.answers[question['id']]?.length ?? 0),
                      ),
                    ),
                    hintText: "type_your_answer_here".tr,
                    bgColor: RGB.blueLight.withAlpha(150),
                    padding: const EdgeInsets.all(8.0),
                    maxLines: 20,
                    onChanged: (value) {
                      print(value);
                      provider.addAnswer(question['id'].toString().toInt, value);
                    },
                    maxLength: 2000,
                  )
                : Wrap(
                    children: answers.map((answer) {
                      return AnswerTile(
                        answer,
                        onPressed: () {
                          provider.addAnswer(question['id'].toString().toInt, answer['id'].toString().toInt);
                        },
                      );
                    }).toList(),
                  ),
          ],
        ),
      );
    });
  }
}

class AnswerTile extends StatefulWidget {
  const AnswerTile(
    this.answer, {
    required this.onPressed,
    super.key,
  });

  final Map answer;
  final Function onPressed;

  @override
  State<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      var hasSelected = provider.checkSelection(widget.answer);

      return MouseRegion(
        onEnter: (event) => setState(() => isHover = true),
        onExit: (event) => setState(() => isHover = false),
        // cursor: MouseCursor.defer,
        child: GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              color: isHover ? RGB.blueLight.withAlpha(150) : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: hasSelected ? Colors.green : RGB.grey.withAlpha(100),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                Icon(
                  color: hasSelected ? Colors.green : RGB.grey.withAlpha(100),
                  hasSelected ? Icons.check_circle_outline_rounded : Icons.circle_outlined,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    "${widget.answer['answer']}",
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
