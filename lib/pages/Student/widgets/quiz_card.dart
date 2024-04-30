import 'package:flutter/material.dart';
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
        onTap: () {
          widget.onPressed();
        },
        child: AnimatedContainer(
          duration: Durations.short1,
          decoration: BoxDecoration(
            color: isHover ? bgColor.withAlpha(250) : bgColor.withAlpha(200),
            borderRadius: BorderRadius.circular(10),
            boxShadow: !isHover
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
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: RGB.black.withAlpha(200),
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
