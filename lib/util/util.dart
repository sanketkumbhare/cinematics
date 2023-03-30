import 'package:intl/intl.dart';

String dateConversion(DateTime dateTime) {
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
}
