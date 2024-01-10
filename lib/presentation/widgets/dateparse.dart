import 'package:intl/intl.dart';

class DateTimeParse {
  static String parsedate({required String timestamp}) {
    int time = int.parse(timestamp.toString());
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    return DateFormat('EEEE dd MMMM').format(dateTime);
  }

   static String parseday({required String timestamp}) {
    int time = int.parse(timestamp.toString());
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    return DateFormat('EEEE').format(dateTime);
  }
}
