import 'package:flutter/widgets.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class WidgetThemes {
  static List<BoxShadow> mainShadow = [
    BoxShadow(
      // blurRadius: 10,
      color: RGB.grey.withOpacity(.4),
      spreadRadius: 1,
    ),
  ];

  static List<BoxShadow> secShadow = [
    BoxShadow(
      blurRadius: 10,
      color: RGB.grey.withOpacity(.4),
      spreadRadius: 1,
    ),
  ];

  static List<BoxShadow> minShadow = [
    BoxShadow(
      blurRadius: 5,
      color: RGB.grey.withOpacity(.3),
    ),
  ];
}
