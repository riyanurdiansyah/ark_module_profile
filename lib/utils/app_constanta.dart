import 'package:intl/intl.dart';
import 'package:html/parser.dart';

NumberFormat numberFormat = NumberFormat.decimalPattern('id');
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}
