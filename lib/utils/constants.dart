import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


///***************************************
///    Enums                             *
///***************************************

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText
      .replaceAll(exp, '\n')
      .replaceAll('\n\n', '\n')
      .replaceAll('\n\n', '\n');
}

String convertFromStringToRange(String rangeString) {
  final value = new NumberFormat("#,###,##0", "en_US");

  return '${value.format(double.parse(rangeString))}';
}

