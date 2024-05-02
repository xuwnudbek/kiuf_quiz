import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/widgets/image.dart';

class CustomQuizWidget extends StatelessWidget {
  CustomQuizWidget({
    required this.index,
    required this.question,
    required this.onPressed,
    super.key,
  });

  final int index;
  final Map question;
  final Function onPressed;

  final List alphabet = ["A", "B", "C", "D", "E", "F"];

  final String qavs = ")";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: RGB.blueLight,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.only(left: 20, bottom: 0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index != 0 ? const Divider() : const SizedBox.shrink(),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(text: "${index + 1}. ", children: [
                    TextSpan(
                      text: "${question['question']}",
                      style: Get.textTheme.titleMedium,
                    ),
                  ]),
                  style: Get.textTheme.titleLarge,
                  selectionColor: Colors.orange,
                ),
              ),
            ],
          ),

          //Answers
          question.isEmpty || question['answers'] == null || question['answers'].isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        onPressed();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red.withAlpha(50)),
                      ),
                      child: Text(
                        "delete".tr,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    ...List.generate(question['answers'].length, (index) {
                      var answer = question['answers'][index];
                      return Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            baseline: TextBaseline.alphabetic,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${alphabet[index]}${answer['is_true'] == 0 ? qavs : ""}',
                                  style: Get.textTheme.titleMedium,
                                ),
                                SizedBox.square(
                                  dimension: 30,
                                  child: answer['is_true'] == 0 ? null : const IMAGE("circle_mark_2.png"),
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: " ${answer['answer']}",
                            style: Get.textTheme.bodyMedium,
                          ),
                        ]),
                        style: Get.textTheme.titleMedium,
                        selectionColor: Colors.red,
                      ).paddingOnly(bottom: 16);
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            onPressed();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red.withAlpha(50)),
                          ),
                          child: Text(
                            "delete".tr,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
