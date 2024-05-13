import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/providers/teacher/question_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_input.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class CustomQuestionWidget extends StatelessWidget {
  const CustomQuestionWidget({
    required this.index,
    required this.isLast,
    super.key,
  });

  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, provider, child) {
        var question = provider.questions[index];

        return Column(
          children: <Widget>[
            const SizedBox(height: 8.0),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: RGB.blueLight,
                  ),
                  height: 200,
                  padding: const EdgeInsets.only(top: 24.0),
                  margin: const EdgeInsets.only(right: 24),
                  child: Column(
                    children: [
                      CustomInput(
                        controller: question.question,
                        hintText: "question_text".tr,
                        maxLines: 3,
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 8),
                          Checkbox(
                            value: !question.isClose,
                            activeColor: RGB.primary,
                            onChanged: (value) {
                              question.isClose = !value!;
                              provider.reload();
                            },
                          ),
                          Text(
                            question.isClose ? "close_quiz".tr : "open_quiz".tr,
                          ),
                          const Spacer(),
                          Visibility(
                            visible: !question.isClose,
                            child: Row(
                              children: [
                                Text(
                                  "${"score_for_this_question".tr}:",
                                ),
                                const SizedBox(width: 8.0),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: RGB.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    width: 60,
                                    height: 40,
                                    child: TextFormField(
                                      controller: question.score,
                                      onChanged: (value) {
                                        provider.calculate();
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "score".tr,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: RGB.grey.withAlpha(150),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 62.5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: RGB.blueLight,
                    ),
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(RGB.white),
                      ),
                      onPressed: () {
                        provider.removeQuestion(context, question);
                        provider.reload();
                      },
                      icon: const Icon(Ionicons.trash, color: Colors.red),
                    ).paddingAll(4.0),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: RGB.blueLight,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: RGB.primary,
                      ),
                      width: 150,
                      height: 40,
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1} of ${provider.questions.length}",
                        style: TextStyle(
                          color: RGB.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Visibility(
              visible: !question.isClose,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: (!question.isClose && isLast) ? question.answers.length + 1 : question.answers.length,
                itemBuilder: (ctx, index) {
                  if (index == question.answers.length && !question.isClose && isLast) {
                    return CustomButton(
                      title: Icon(
                        Icons.add,
                        color: RGB.black.withOpacity(.7),
                        size: 36,
                      ),
                      bgColor: RGB.black.withOpacity(.05),
                      onPressed: () {
                        question.addAnswer();
                        provider.reload();
                      },
                    ).marginOnly(right: 24, bottom: 14);
                  }

                  var answer = question.answers[index];
                  return Stack(
                    children: [
                      const SizedBox(height: 150, width: double.infinity),
                      CustomInput(
                        controller: answer.answer,
                        border: index > 0 ? null : Border.all(color: Colors.green, width: 2),
                        hintText: index > 0 ? "false_answer".tr : "true_answer".tr,
                        maxLines: 3,
                      ).marginOnly(right: 24),
                      index == 0
                          ? const SizedBox.shrink()
                          : Positioned(
                              top: 20,
                              right: 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: RGB.blueLight,
                                ),
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(RGB.white),
                                  ),
                                  highlightColor: Colors.red.withAlpha(25),
                                  onPressed: () {
                                    question.removeAnswer(answer);
                                    provider.reload();
                                  },
                                  icon: const Icon(Ionicons.trash, color: Colors.red),
                                ).paddingAll(4.0),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }
}
