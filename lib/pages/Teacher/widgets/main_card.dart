import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/providers/teacher/teacher_provider.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/functions/check_status.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class MainCard extends StatefulWidget {
  const MainCard(
    this.data, {
    required this.index,
    super.key,
  });

  final Map data;
  final int index;

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  bool isHovered = false;

  List<Color> statusColors = [
    Colors.orange,
    Colors.green,
    Colors.red,
  ];

  List statuses = [
    {"id": 1, "name": "Boshlanmagan"},
    {"id": 2, "name": "Jarayonda"},
    {"id": 3, "name": "Tugagan"},
  ];

  List typeQuiz = [
    "Oraliq",
    "Yakuniy",
  ];

  @override
  void initState() {
    setState(() {
      widget.data['status'] = checkStatus(widget.data['start_time'].toString().toDateTime, widget.data['end_time'].toString().toDateTime);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherProvider>(builder: (context, provider, _) {
      return MouseRegion(
        onEnter: (event) => setState(() {
          isHovered = true;
        }),
        onExit: (event) => setState(() {
          isHovered = false;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: RGB.blueLight,
            border: Border.all(
              color: RGB.primaryLight.withOpacity(.1),
              width: 1.0,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: RGB.black.withOpacity(0.07),
                      blurRadius: 7.0,
                      spreadRadius: 2.0,
                      offset: const Offset(2, 4),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.data['subject']}",
                style: TextStyle(
                  color: RGB.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: RGB.primaryLight.withOpacity(.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"tests".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "${(widget.data['questions'] ?? []).length} ${'counter'.tr}",
                              style: TextStyle(
                                color: RGB.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text(
                            "${"status_quiz".tr}: ",
                            style: TextStyle(
                              color: RGB.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 4.0),
                              Container(
                                width: 16.0,
                                height: 16.0,
                                decoration: BoxDecoration(
                                  color: statusColors[widget.data['status'] - 1],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                statuses[widget.data['status'] - 1]["name"],
                                style: TextStyle(
                                  color: statusColors[widget.data['status'] - 1],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"type_quiz".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: typeQuiz[widget.data['type']],
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"quiz_date".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: widget.data['start_time'].toString().split(" ")[0],
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"start_time".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: widget.data['start_time'].toString().toTime,
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"end_time".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: widget.data['end_time'].toString().toTime,
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      //Edit button
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("edit_quiz".tr),
                                ],
                              ),
                              outlinedBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              bgColor: RGB.primary,
                              onPressed: () {
                                Storage.setQuizId(widget.data["id"]);
                                Get.toNamed("/show-quiz")!.then((value) {
                                  provider.init();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: RGB.primary.withAlpha(25),
                              highlightColor: RGB.primary.withAlpha(50),
                              shape: const CircleBorder(),
                            ),
                            icon: Icon(
                              Icons.bar_chart_rounded,
                              color: RGB.primary,
                              size: 31,
                            ),
                            onPressed: () {
                              Storage.setQuizId(widget.data["id"]);
                              Get.toNamed("/check-results");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void copyToClipboard(ctx, String id) {
    Clipboard.setData(ClipboardData(text: id));
    CustomSnackbars.success(ctx, "${"copied".tr}: $id");
  }
}
