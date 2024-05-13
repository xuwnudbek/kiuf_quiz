extension StringExtension on String {
  int get toInt => int.tryParse(this) ?? 0;
  double get toDouble => double.tryParse(this) ?? 0.0;

  DateTime get toDateTime => DateTime.tryParse(this) ?? DateTime.now();
  String get toTime => split(" ")[1].substring(0, 5);
}
