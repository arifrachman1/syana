class GlobalVars{
  /*urls*/
  static final String baseUrl = "http://192.168.1.67:8080/";
//  static final String baseUrl = "http://syana.mamorasoft.com/";
  static final String apiUrl = baseUrl + "syana/api/";
//  static final String apiUrl = baseUrl + "api/";

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

  /*sale*/
  static String airwayBillNumber = "";
  static clearAirwayBillNumber(){
    airwayBillNumber = "";
  }
  static String customerId = "";
  static String customerFullName = "";
  static int selectedEcommerce = 0;
}