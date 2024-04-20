import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class NotFound extends StatefulWidget {
  const NotFound({super.key});

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/404.png",
              // color: RGB.primary,
              width: 300,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.offAllNamed("/splash");
              },
              child: Text(
                "Back To Home",
                style: Get.textTheme.titleSmall!.copyWith(
                  color: RGB.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
