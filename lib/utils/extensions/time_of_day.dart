import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String toFormattedString() {
    return '$hour:$minute';
  }
}
