import 'package:get_storage/get_storage.dart';

class Storage {
  static GetStorage box = GetStorage("kiuf_quiz");

  //quiz_id
  static int quizId = box.read("quiz_id");
  static setQuizId(int id) {
    quizId = id;
    box.write("quiz_id", id);
  }

  //question_id
  static int questionId = box.read("question_id");
  static setQuestionId(int id) {
    questionId = id;
    box.write("question_id", id);
  }

  // Write data to storage
  static void write(String key, dynamic value) {
    box.write(key, value);
  }

  // Read data from storage
  static dynamic read(String key) {
    return box.read(key);
  }

  // Remove data from storage
  static void remove(String key) {
    box.remove(key);
  }

  // Clear all data from storage
  static void clear() {
    box.erase();
  }

  // Check if data exists in storage
  static bool hasData(String key) {
    return box.hasData(key);
  }
}