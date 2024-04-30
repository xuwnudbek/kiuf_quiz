import 'package:flutter/material.dart';

import 'package:kiuf_quiz/utils/rgb.dart';

class CustomSquareButton extends StatelessWidget {
  const CustomSquareButton({
    required this.child,
    required this.onPressed,
    this.size = 50,
    this.bgColor,
    super.key,
  });

  final double size;
  final Widget child;
  final Color? bgColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        side: BorderSide(color: RGB.primary.withAlpha(100)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: child,
    );
  }
}
