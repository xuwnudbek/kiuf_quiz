import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/language/en.dart';
import 'package:kiuf_quiz/controllers/language/uz.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'uz': uz,
        'en': en,
      };
}
