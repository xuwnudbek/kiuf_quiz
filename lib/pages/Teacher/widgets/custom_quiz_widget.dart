import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/providers/teacher/show_quiz_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/image.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class CustomQuizWidget extends StatelessWidget {
  CustomQuizWidget({
    required this.index,
    super.key,
  });

  final int index;

  final alphabet = ["A", "B", "C", "D", "E", "F"];

  String qavs = ")";

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowQuizProvider>(builder: (context, provider, _) {
      var question = provider.questions[index];
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
            (question ?? []).isEmpty || question['answers'] == null || question['answers'].isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await provider.deleteQuestion(question['id'].toString()).then((value) {
                            provider.initialize();
                          });
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
                      SizedBox(height: 16.0),
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
                              await provider.deleteQuestion(question['id'].toString()).then((value) {
                                provider.initialize();
                              });
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
    });
  }
}
