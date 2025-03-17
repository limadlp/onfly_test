import 'package:intl/intl.dart';

class FormatUtils {
  FormatUtils._();
  static String formatDate(String isoDate) {
    if (!isoDate.contains('T') && !isoDate.contains('Z')) {
      return isoDate;
    }
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
