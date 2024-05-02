import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/functions/check_status.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class QuizCard extends StatefulWidget {
  const QuizCard({
    required this.quiz,
    required this.onPressed,
    super.key,
  });

  final Map quiz;
  final Function onPressed;

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  bool isHover = false;
  int? status;

  initStatus(DateTime startTime, DateTime endTime) {
    status = checkStatus(startTime, endTime);
  }

  Color bgColor = RGB.blueLight;

  Future<bool> checkQuizStatus() async {
    if (status == null || status == 1 || status == 3) {
      await Get.dialog(Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              color: RGB.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "you_cant_start_this_quiz".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "quiz_time_is".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.quiz['start_time'].toString().substring(0, 16),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.quiz['end_time'].toString().substring(0, 16),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: RGB.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("ok".tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));

      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkAnsweredOrNot() async {
    if (widget.quiz['status'] ?? false) {
      await Get.dialog(Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 350,
            height: 125,
            decoration: BoxDecoration(
              color: RGB.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                const SizedBox(height: 16),
                Text(
                  "this_quiz_already_answered".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red.withAlpha(255),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: RGB.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("ok".tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    initStatus(
      widget.quiz['start_time'].toString().toDateTime,
      widget.quiz['end_time'].toString().toDateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () async {
          if (await checkAnsweredOrNot()) return;
          var status = await checkQuizStatus();
          if (status == true) {
            widget.onPressed();
          }
        },
        child: AnimatedContainer(
          duration: Durations.short1,
          decoration: BoxDecoration(
            color: widget.quiz['status']
                ? RGB.grey.withAlpha(100)
                : isHover
                    ? bgColor.withAlpha(250)
                    : bgColor.withAlpha(200),
            borderRadius: BorderRadius.circular(10),
            boxShadow: !isHover || widget.quiz['status']
                ? []
                : [
                    BoxShadow(
                      color: RGB.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(4, 4),
                    )
                  ],
          ),
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.quiz['subject']}",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: RGB.black.withAlpha(150),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.quiz['start_time'].toString().toTime} - ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: RGB.black.withAlpha(150),
                        ),
                      ),
                      Text(
                        widget.quiz['end_time'].toString().toTime,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: RGB.black.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.quiz['type'] == 0 ? "Oraliq" : "Yakuniy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: RGB.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text("|"),
                      const SizedBox(width: 8),
                      Text(
                        status == null
                            ? "Tekshirilmoqda"
                            : status == 1
                                ? "Boshlanmagan"
                                : status == 2
                                    ? "Jarayonda"
                                    : status == 3
                                        ? "Tugagan"
                                        : "Nomalum",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: status == null
                              ? Colors.black
                              : status == 1
                                  ? Colors.orange
                                  : status == 2
                                      ? Colors.green
                                      : status == 3
                                          ? Colors.red
                                          : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
