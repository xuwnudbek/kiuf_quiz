extension StringExtension on String {
  int get toInt => int.tryParse(this) ?? 0;

  DateTime get toDateTime => DateTime.tryParse(this) ?? DateTime.now();
}
