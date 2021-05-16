import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

main() async {
  test("Date", () {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse("2021-05-10 00:00:00.000");
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
  });
  test("Short Date List", () {});
}
