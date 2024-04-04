import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    required this.controller,
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.formatters,
    super.key,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? hintText;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
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
              obscureText: show,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? "",
                hintStyle: Get.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Visibility(
            visible: widget.obscureText,
            child: IconButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });

                if (!show) {
                  Future.delayed(
                    const Duration(seconds: 3),
                    () {
                      setState(() {
                        show = !show;
                      });
                    },
                  );
                }
              },
              icon: Icon(
                show ? Ionicons.eye_off_outline : Ionicons.eye_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
