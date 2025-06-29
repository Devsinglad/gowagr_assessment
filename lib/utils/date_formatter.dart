import 'package:intl/intl.dart';

String? formattedDueDate({date}) {
  final DateFormat formatter = DateFormat('dd MMM, yyyy');
  return formatter.format(date);
}

String? formatDueDate({date}) {
  DateTime dateTime = DateTime.parse(date);

  return DateFormat('dd MMM, yyyy').format(dateTime);
}

String convertIsoToTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString).toLocal();
  return DateFormat('h:mma').format(dateTime);
}

String convertIsoToDate(String isoString) {
  DateTime dateTime = DateTime.parse(isoString).toLocal();
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

String getDaysFromTodayFutureOnly(String isoDate) {
  try {
    DateTime targetDate = DateTime.parse(isoDate);
    DateTime today = DateTime.now();

    DateTime todayDate = DateTime(today.year, today.month, today.day);
    DateTime targetDateOnly =
        DateTime(targetDate.year, targetDate.month, targetDate.day);

    Duration difference = targetDateOnly.difference(todayDate);
    int days = difference.inDays.abs(); // Always positive

    if (days == 0) {
      return 'Today';
    } else if (days == 1) {
      return '1 Day';
    } else {
      return '$days Days';
    }
  } catch (e) {
    print('Error parsing date: $e');
    return '0 Days';
  }
}
