import 'package:get_storage/get_storage.dart';

class Storage {
  static GetStorage box = GetStorage("kiuf_quiz");

  //auth user
  static Map user = box.read('user') ?? {};
  static setUser(value) {
    user = value;
    box.write('user', user);
  }

  //auth token
  static String token = box.read('token') ?? "";
  static setToken(value) {
    token = value;
    box.write('token', token);
  }

  //quiz_id
  static int? quizId = box.read("quiz_id");
  static setQuizId(int id) {
    quizId = id;
    box.write("quiz_id", id);
  }

  //question_id
  static int? questionId = box.read("question_id");
  static setQuestionId(int id) {
    questionId = id;
    box.write("question_id", id);
  }

  // Remove data from storage
  static void remove(String key) {
    box.remove(key);
  }

  // Clear all data from storage
  static void clear() {
    box.erase();
    save();
  }

  // Check if data exists in storage
  static bool hasData(String key) {
    return box.hasData(key);
  }

  static void save() {
    box.save();
  }
}
