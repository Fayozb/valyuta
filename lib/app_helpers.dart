class AppHelpers {
  static String getFormattedDate(DateTime date) {
    return '${date.year}-${date.month > 9 ? date.month : '0${date.month}'}-${date.day > 9 ? date.day : '0${date.day}'}';
  }
}
