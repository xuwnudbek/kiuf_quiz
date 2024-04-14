import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.title,
    this.bgColor,
    this.splashColor,
    this.onPressed,
    super.key,
  });

  final Widget title;
  final Color? bgColor;
  final Color? splashColor;
  final Function()? onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(widget.bgColor ?? RGB.primary),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        overlayColor: MaterialStatePropertyAll(widget.bgColor ?? RGB.primary),
        elevation: const MaterialStatePropertyAll(0.0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(RGB.white),
      ),
      onPressed: () {
        widget.onPressed?.call();
      },
      child: widget.title.paddingSymmetric(
        horizontal: 16.0,
        vertical: 14.0,
      ),
    );
  }
}
