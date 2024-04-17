import 'package:flutter/widgets.dart';

class Answer {
  late TextEditingController text;

  Answer() {
    text = TextEditingController();
  }

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
