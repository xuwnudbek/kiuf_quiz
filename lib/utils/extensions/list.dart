extension StringExtension on List {
  int lengthOf(search, field) {
    return where((element) => element[field]).length;
  }
}
