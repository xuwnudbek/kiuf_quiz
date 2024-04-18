import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/providers/student/quiz_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class StudentQuestionWidget extends StatelessWidget {
  const StudentQuestionWidget({
    required this.question,
    required this.isOpen,
    required this.index,
    super.key,
  });

  final Map question;
  final int index;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      return SizedBox(
        width: Get.width * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(text: "${index + 1}. ", children: [
                TextSpan(
                  text: "In publishing and design, Lorem ipsum In publishing and graphic design, Lorem ipsum In publishing and graphic design, Lorem ipsum",
                  style: Get.textTheme.titleMedium,
                ),
              ]),
              style: Get.textTheme.titleLarge,
              selectionColor: Colors.orange,
            ),
            const SizedBox(height: 32.0),
            !isOpen
                ? CustomInput(
                    controller: TextEditingController(),
                    hintText: "Type your answer here",
                    bgColor: RGB.blueLight.withAlpha(150),
                    padding: const EdgeInsets.all(8.0),
                    maxLines: 20,
                  )
                : Wrap(
                    children: List.generate(4, (index) {
                      return AnswerTile(
                        {"id": index},
                        onPressed: () {
                          print("Answer selected");
                        },
                      );
                    }),
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
    return MouseRegion(
      onEnter: (event) => setState(() => isHover = true),
      onExit: (event) => setState(() => isHover = false),
      cursor: MouseCursor.defer,
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHover ? RGB.blueLight : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Radio(
                groupValue: 0,
                value: true,
                onChanged: (value) {},
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  "In publishing and design, Lorem ipsum In publishing and graphic design, Lorem ipsum In publishing and graphic design, Lorem ipsum",
                  style: Get.textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
