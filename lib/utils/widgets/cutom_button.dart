import 'package:flutter/material.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.title,
    this.bgColor,
    this.onPressed,
    super.key,
  });

  final Widget title;
  final Color? bgColor;
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
        elevation: const MaterialStatePropertyAll(0.0),
        maximumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 60),
        ),
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: () {
        widget.onPressed?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.title,
        ],
      ),
    );
  }
}
