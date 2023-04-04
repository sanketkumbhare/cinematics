import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String dateConversion(DateTime dateTime) {
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
}

extension RouterContext on BuildContext{
   toNamed(String routeName, {Object? args}) =>
   Navigator.of(this).pushNamed(routeName,arguments: args);
}