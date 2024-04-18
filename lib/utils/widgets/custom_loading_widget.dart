import 'package:flutter/material.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 100,
        child: CircularProgressIndicator(
          color: RGB.primary.withAlpha(200),
        ),
      ),
    );
  }
}
