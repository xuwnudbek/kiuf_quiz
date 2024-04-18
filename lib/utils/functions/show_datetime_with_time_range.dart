
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_snackbars.dart';

import 'input_formatters.dart';

class ShowDatetimeWithTimeRange extends StatefulWidget {
  const ShowDatetimeWithTimeRange({super.key});

  @override
  State<ShowDatetimeWithTimeRange> createState() => _ShowDatetimeWithTimeRangeState();
}

class _ShowDatetimeWithTimeRangeState extends State<ShowDatetimeWithTimeRange> {
  DateTime? day;
  var fromHour = TextEditingController();
  var fromMinute = TextEditingController();

  var toHour = TextEditingController();
  var toMinute = TextEditingController();

  void setDay(value) {
    setState(() {
      day = value;
    });
  }

  void onSubmitted() {
    var from = TimeOfDay(hour: fromHour.text.toInt, minute: fromMinute.text.toInt);
    var to = TimeOfDay(hour: toHour.text.toInt, minute: toMinute.text.toInt);

    day ??= DateTime.now();

    if (from.hour > to.hour || (from.hour == to.hour && from.minute > to.minute)) {
      CustomSnackbars.warning(context, "from_time_must_be_less_than_to_time".tr);
      return;
    } else if (from.hour == to.hour && from.minute == to.minute) {
      CustomSnackbars.warning(context, "from_time_must_be_less_than_to_time".tr);
      return;
    }

    var dateWithTime = DateWithTime(day!, from, to);

    Get.back(result: dateWithTime);
  }

  @override
  void initState() {
    super.initState();

    fromHour.addListener(() {
      if (fromHour.text.length == 2) {
        FocusScope.of(context).nextFocus();
      }
    });

    fromMinute.addListener(() {
      if (fromMinute.text.length == 2) {
        FocusScope.of(context).nextFocus();
      }
    });

    toHour.addListener(() {
      if (toHour.text.length == 2) {
        FocusScope.of(context).nextFocus();
      }
    });

    toMinute.addListener(() {
      if (toMinute.text.length == 2) {
        FocusScope.of(context).nextFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.blueLight.withOpacity(.7),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
                minWidth: 400,
                minHeight: 600,
                maxHeight: 630,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: RGB.black.withOpacity(.1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("select_date_time_range".tr, style: Get.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 400,
                    child: Material(
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 62)),
                        onDateChanged: (DateTime date) {
                          setDay(date);
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("from".tr, style: Get.textTheme.titleMedium),
                          Container(
                            width: 175,
                            height: 75,
                            decoration: BoxDecoration(
                              color: RGB.blueLight,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                TimeTextField(ctrl: fromHour, formatter: checkTimeHour),
                                const Text(
                                  ":",
                                  style: TextStyle(fontSize: 36),
                                ),
                                TimeTextField(ctrl: fromMinute, formatter: checkTimeMinute),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("to".tr, style: Get.textTheme.titleMedium),
                          Container(
                            width: 175,
                            height: 75,
                            decoration: BoxDecoration(
                              color: RGB.blueLight,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                TimeTextField(ctrl: toHour, formatter: checkTimeHour),
                                const Text(
                                  ":",
                                  style: TextStyle(fontSize: 36),
                                ),
                                TimeTextField(ctrl: toMinute, formatter: checkTimeMinute),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Buttons
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(RGB.grey),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          elevation: const MaterialStatePropertyAll(0),
                        ),
                        child: Text('cancel'.tr),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          onSubmitted();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(RGB.primary),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          elevation: const MaterialStatePropertyAll(0),
                        ),
                        child: Text('save'.tr),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Close button
          Align(
            alignment: const Alignment(0, -0.9),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(100, 50)),
              ),
              child: const Icon(Ionicons.close),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeTextField extends StatelessWidget {
  const TimeTextField({
    super.key,
    required this.ctrl,
    this.formatter,
  });

  final TextEditingController ctrl;
  final TextEditingValue Function(TextEditingValue, TextEditingValue)? formatter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: ctrl,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          TextInputFormatter.withFunction(formatter ?? (oldValue, newValue) => newValue),
        ],
        decoration: InputDecoration(
          hintText: "00",
          hintStyle: Get.textTheme.titleLarge!.copyWith(
            color: RGB.grey.withOpacity(.3),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: Get.textTheme.titleLarge,
      ),
    );
  }
}

class DateWithTime {
  final DateTime day;
  final TimeOfDay from;
  final TimeOfDay to;

  DateWithTime(this.day, this.from, this.to);
}
