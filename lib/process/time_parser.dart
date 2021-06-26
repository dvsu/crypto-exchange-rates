import 'package:intl/intl.dart';

class TimeParser {
  final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');

  String utcToLocalTimeAsString(String utcTime) {
    DateTime resDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").parseUTC(utcTime).toLocal();
    return formatter.format(resDate);
  }
}
