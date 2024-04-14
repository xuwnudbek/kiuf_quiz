import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomSnackbars {
  static success(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: RGB.primary,
        content: Text(
          msg,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: RGB.white,
          ),
        ),
      ),
    );
  }

  static warning(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(
          msg,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: RGB.white,
          ),
        ),
      ),
    );
  }
}
