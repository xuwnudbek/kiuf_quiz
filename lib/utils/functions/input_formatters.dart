import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiuf_quiz/utils/extensions/string.dart';

TextEditingValue checkTimeHour(TextEditingValue oldValue, TextEditingValue newValue) {
  if (newValue.text.toInt < 0) {
    return const TextEditingValue();
  }

  if (newValue.text.toInt > 24) {
    newValue = const TextEditingValue(
      text: "24",
      selection: TextSelection.collapsed(offset: 2),
    );
  }

  return newValue;
}

TextEditingValue checkTimeMinute(TextEditingValue oldValue, TextEditingValue newValue) {
  if (newValue.text.toInt < 0) {
    return const TextEditingValue();
  }
  if (newValue.text.toInt > 59) {
    newValue = const TextEditingValue(
      text: "59",
      selection: TextSelection.collapsed(offset: 2),
    );
  }

  return newValue;
}
