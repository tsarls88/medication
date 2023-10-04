String convertTime(int hour, int minute) {
  int formattedHour = hour;
  String period = 'AM';

  if (formattedHour >= 12) {
    period = 'PM';
    if (formattedHour > 12) {
      formattedHour -= 12;
    }
  }

  if (formattedHour == 0) {
    formattedHour = 12;
  }

  String formattedMinute = minute.toString().padLeft(2, '0');

  return '$formattedHour:$formattedMinute $period';
}
