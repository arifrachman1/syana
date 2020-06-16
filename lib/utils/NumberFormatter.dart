import 'package:intl/intl.dart';

class NumberFormatter {
  static final currency = NumberFormat.currency(locale: "en_ID", name: "Rp. ");
  static final numberWithDecimals = NumberFormat.compact();

  static String getCurrency(double number) {
    return currency.format(number);
  }

  static getFormattedNumber(double number) {
    return numberWithDecimals.format(number);
  }
}
