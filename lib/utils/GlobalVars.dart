// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class GlobalVars {
  /*urls*/
  // static final String baseUrl = "http://192.168.43.123/";
  static final String baseUrl = "http://arsyad-wew.ddns.net/";
//  static final String baseUrl = "http://syana.mamorasoft.com/";
//  static final String baseUrl = "http://hq.syana.co.id/";
  /* static final String apiUrl = baseUrl + "syana/api/";
  static final String rankUrl = baseUrl + "syana/rank/";
  static final String siteUrl = baseUrl + "syana/site/";
  static final String summaryUrl = baseUrl + "syana/summary/";
  static final String bookmarkUrl = baseUrl + "syana/bookmark/";
  static final String saleUrl = baseUrl + "syana/sale/"; */

  static final String apiUrl = baseUrl + "api/";
  static final String rankUrl = baseUrl + "rank/";
  static final String siteUrl = baseUrl + "site/";
  static final String summaryUrl = baseUrl + "summary/";
  static final String bookmarkUrl = baseUrl + "bookmark/";
  static final String saleUrl = baseUrl + "sale/";

  // static final String imageUrl = baseUrl + "syana/products/";

  static final String purchasingUrl = baseUrl + "purchasing/";

  static final String imageUrl = baseUrl + "products/";

  static final String thumbnailUrl = baseUrl + "syana/thumbnail/";

  static String YOUTUBE_API_KEY = "AIzaSyCyjg0Dq4NsQF6uLLNySsP2KR1JuGA7l9I";

  /*fcm*/
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static bool fcm_message_received = false;

  /*dev-mode*/
  static bool isDevMode = true;

  /*shared preference*/
  static final String idKey = "ID";
  static final String nameKey = "NAME";
  static final String fullNameKey = "FULLNAME";
  static final String dateTimeJoinedKey = "DATETIMEJOINED";
  static final String idRoleKey = "IDROLE";
  static final String idTeamKey = "IDTEAM";
  static final String accessTokenKey = "ACCESSTOKEN";
  static final String ecommerceKey = "ECOMMERCE";

  static final String firstShortcutKey = "FIRSTSHORTCUT";
  static final String secondShortcutKey = "SECONDSHORTCUT";
  static final String thirdShortcutKey = "THIRDSHORTCUT";

  /*sale*/
  static String airwayBillNumber = "";
  static clearAirwayBillNumber() {
    airwayBillNumber = "";
  }

  static String customerId = "";
  static String customerFullName = "";
  static int selectedEcommerce = 0;

  /*shortcut*/
}
