import 'package:intl/intl.dart';

class NumberFormatter{
  static final currency = NumberFormat.currency(locale: "en_ID", name: "Rp. ");

  static String getCurrency(double number){
    return currency.format(number);
  }
}