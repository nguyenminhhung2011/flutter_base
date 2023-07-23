import 'package:intl/intl.dart';

extension IntExtension on int {
  String get price =>
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(this);
}
