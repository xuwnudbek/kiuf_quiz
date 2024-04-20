import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    required this.data,
    this.hintText = "Tanlang",
    this.onChange,
    this.size = const Size(250.0, 50.0),
    this.fillColor,
    this.disabled = false,
    super.key,
  });

  final List data;
  final Size size;
  final bool disabled;
  final String hintText;
  final Color? fillColor;
  final Function(Map one)? onChange;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int selectedItemIndex = null.hashCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: widget.fillColor ?? RGB.blueLight,
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: widget.disabled
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.hintText,
                    style: Get.textTheme.bodyMedium,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonStyleData: const ButtonStyleData(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  height: 50,
                ),
                style: Get.textTheme.bodyMedium,
                dropdownStyleData: DropdownStyleData(
                  elevation: 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: RGB.black.withOpacity(.2),
                        blurRadius: 8.0,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                ),
                isExpanded: true,
                value: selectedItemIndex,
                items: [
                  DropdownMenuItem(
                    value: null.hashCode,
                    enabled: false,
                    child: Text(
                      widget.hintText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...widget.data.map((value) {
                    return DropdownMenuItem(
                      value: value.hashCode,
                      child: Text(
                        value['name'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                ],
                onChanged: (code) {
                  if (widget.onChange == null) return;
                  var res = widget.data.firstWhere((element) => element.hashCode == code);
                  widget.onChange!(res);
                  setState(() {
                    selectedItemIndex = code ?? 0;
                  });
                },
              ),
            ),
    );
  }
}
