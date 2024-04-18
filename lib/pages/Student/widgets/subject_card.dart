import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard(
    this.subject, {
    required this.onPressed,
    super.key,
  });

  final Map subject;
  final Function onPressed;

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool isHover = false;

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
            color: isHover ? RGB.blueLight : RGB.blueLight.withAlpha(150),
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
          child: Center(
            child: Text(
              "Subject ${widget.subject['name']}",
              style: Get.textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
