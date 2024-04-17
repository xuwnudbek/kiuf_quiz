import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    required this.controller,
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.bgColor,
    this.formatters,
    this.padding,
    this.maxLines,
    this.border,
    super.key,
  });

  final TextEditingController controller;
  final Border? border;
  final IconData? prefixIcon;
  final Color? bgColor;
  final String? hintText;
  final bool obscureText;
  final int? maxLines;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? formatters;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool? show;

  @override
  void initState() {
    show = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: widget.border ??
            Border.all(
              color: RGB.white.withOpacity(.3),
              width: 0.5,
            ),
        color: widget.bgColor ?? RGB.white,
      ),
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Visibility(
            visible: widget.prefixIcon != null,
            child: Icon(widget.prefixIcon).paddingOnly(left: 12.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: TextFormField(
              inputFormatters: widget.formatters ?? [],
              controller: widget.controller,
              obscureText: show ?? false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? "",
                hintStyle: Get.textTheme.bodyMedium!.copyWith(
                  color: Colors.black26,
                ),
              ),
              maxLines: widget.maxLines,
            ),
          ),
          const SizedBox(width: 12.0),
          Visibility(
            visible: widget.obscureText,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      show = !(show ?? false);
                    });
                    if (!(show ?? false)) {
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          setState(() {
                            show = !(show ?? false);
                          });
                        },
                      );
                    }
                  },
                  icon: Icon(
                    show ?? false ? Ionicons.eye_off_outline : Ionicons.eye_outline,
                  ),
                ),
                const SizedBox(width: 4.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
