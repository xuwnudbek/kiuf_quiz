import 'dart:math';

void main(List<String> args) {
  List opts = ["s1", "s2", "a1", "a2"];
  List names = ["Xuwnudbek", "Bunyodbek", "Jamshid", "Muhammadali"];

  for (var name in names) {
    var opt = opts[Random().nextInt(opts.length)];
    opts.remove(opt);
    print("$name: $opt");
  }
}
