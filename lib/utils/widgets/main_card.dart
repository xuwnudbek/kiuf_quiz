import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/pages/Teacher/views/check_results.dart';
import 'package:kiuf_quiz/providers/teacher/teacher_provider.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/functions/check_status.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';
import 'package:kiuf_quiz/utils/widgets/custom_square.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:kiuf_quiz/utils/widgets/svg.dart';
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
        child: Container(
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
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: RGB.primaryLight.withOpacity(.1),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "${widget.data["id"]}",
                      style: Get.textTheme.titleSmall!.copyWith(
                        color: RGB.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Positioned(
                      right: 6.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.copy_all_rounded,
                          color: RGB.primary,
                        ),
                        onPressed: () {
                          copyToClipboard(context, "${widget.data["id"]}");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "#${widget.index + 1} test",
                style: Get.textTheme.titleMedium!.copyWith(
                  color: RGB.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.0),
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
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${"subject".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "${widget.data['subject']}",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w400,
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
                              text: "${"count_all".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "${(widget.data['questions'] ?? []).length} ${'counter'.tr}",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w400,
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
                              text: "${"open_quiz".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "0 ${'counter'.tr}",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w400,
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
                              text: "${"close_quiz".tr}: ",
                              style: TextStyle(
                                color: RGB.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: "0 ${'counter'.tr}",
                              style: TextStyle(
                                color: RGB.primary,
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
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text(
                            "${"type_quiz".tr}: ",
                            style: TextStyle(
                              color: RGB.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            typeQuiz[widget.data['type']],
                            style: TextStyle(
                              color: RGB.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                          CustomSquareButton(
                            child: Icon(
                              Icons.bar_chart_rounded,
                              color: RGB.primary,
                              size: 31,
                            ),
                            onPressed: () {
                              Storage.setQuizId(widget.data["id"]);
                              Get.toNamed("/check-results")?.then((value) {
                                provider.init();
                              });
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
