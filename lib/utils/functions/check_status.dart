int checkStatus(DateTime startTime, DateTime endTime) {
  var now = DateTime.now();
  int result = 0;

  if (now.isBefore(startTime)) {
    result = 1;
  }

  if (now.isAfter(startTime) && now.isBefore(endTime)) {
    result = 2;
  }

  if (now.isAfter(endTime)) {
    result = 3;
  }

  return result;
}
