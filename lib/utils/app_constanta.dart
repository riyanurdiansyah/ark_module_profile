import 'package:intl/intl.dart';
import 'package:html/parser.dart';

NumberFormat numberFormat = NumberFormat.decimalPattern('id');
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

List<String> listProfesi = [
  'Silahkan Pilih Profesi',
  'Karyawan Swasta',
  'PNS & BUMN',
  'Profesional',
  'Wiraswasta',
  'Pelajar/Mahasiswa',
  'Belum Bekerja',
  'Lainnya',
];

List<String> listPendidikan = [
  "Silahkan Pilih Pendidikan",
  "SD",
  "SMP",
  "SMA",
  "S1",
  "S2",
];
