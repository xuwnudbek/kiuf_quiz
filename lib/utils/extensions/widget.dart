import 'package:flutter/material.dart';

extension WidgetExtentions on Widget {
  Widget decorator() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: this,
    );
  }
}
