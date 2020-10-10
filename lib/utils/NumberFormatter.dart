import 'package:intl/intl.dart';

class NumberFormatter {
  static final currency = NumberFormat.currency(locale: "en_ID", name: "Rp. ");
  static final numberWithDecimals = NumberFormat.decimalPattern("en_ID");
  static final decimalsWithoutTrailingZero = NumberFormat.compact(locale: "en_ID");

  static String getCurrency(double number) {
    return currency.format(number);
  }

  static getFormattedNumber(number) {
    if(!(number is double)){
      if(number is String){
        number = double.parse(number);
      }else{
        number = double.parse(number.toString());
      }
    }
    return numberWithDecimals.format(number);
  }

  static removeZeroBehindDecimals(number) {
	  if (!(number is double)) {
		  if (number is String) {
			  number = double.parse(number);
		  } else {
			  number = double.parse(number.toString());
		  }
	  }
	  return numberWithDecimals.format(number);
  }
}
