import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';

class MainCard extends StatefulWidget {
  const MainCard(
    this.data, {
    super.key,
  });

  final Map data;

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

  late int index;
  @override
  void initState() {
    super.initState();
    index = Random().nextInt(3);
  }

  @override
  Widget build(BuildContext context) {
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
                    "0123456789",
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
                        copyToClipboard("1234567890");
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "#1 test",
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
                            text: "Matematika",
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
                            text: "5 ta",
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
                            text: "10 ta",
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
                            text: "${"closed_quiz".tr}: ",
                            style: TextStyle(
                              color: RGB.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "5 ta",
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
                            Container(
                              width: 16.0,
                              height: 16.0,
                              decoration: BoxDecoration(
                                color: statusColors[index],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              statuses[index]["name"],
                              style: TextStyle(
                                color: statusColors[index],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Spacer(),
                    //Edit button
                    CustomButton(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("edit_quiz".tr),
                        ],
                      ),
                      bgColor: RGB.primary,
                      onPressed: () {
                        Storage.setQuizId(widget.data["id"]);
                        Get.toNamed("/show-quiz");
                      },
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void copyToClipboard(String id) {
    Clipboard.setData(ClipboardData(text: id));
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        message: "${"copied".tr}: 1234567890",
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
