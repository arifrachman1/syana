import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/home/SyanaHomeOwner.dart';
import 'package:syana/screens/home/SyanaHomeStarSeller.dart';
import 'package:syana/screens/inventory/SyanaStock.dart';
import 'package:syana/screens/product_rank/SyanaProductRank.dart';
import 'package:syana/screens/profile/SyanaProfileBase.dart';
import 'package:syana/screens/sale/SyanaEcommerce.dart';
import 'package:syana/widgets/CustomDialog.dart';

import 'GlobalVars.dart';
import 'Strings.dart';

class GlobalFunctions {
  static Future<UserModel> getPersistence() async {
    UserModel userModel;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel = new UserModel(
        prefs.get(GlobalVars.idKey),
        prefs.get(GlobalVars.nameKey),
        prefs.get(GlobalVars.fullNameKey),
        prefs.get(GlobalVars.dateTimeJoinedKey),
        prefs.get(GlobalVars.idRoleKey),
        prefs.get(GlobalVars.idTeamKey),
        prefs.get(GlobalVars.accessTokenKey));

    return userModel;
  }

  static Future<dynamic> dioGetCall({params, path, context, options}) async {
    Dio dio;
    Response _localResp;
    var data;

    dev.log(params is FormData ? params.fields.toString() : params.toString());
    dev.log(path.toString());

    try {
      dio = new Dio();
      _localResp =
          await dio.get(path, options: options, queryParameters: params);
      data = _localResp.data;
    } on DioError catch (e) {
      print(e.response.toString());
      GlobalFunctions.log(message: e.toString(), name: "dio_get_call");
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    } catch (e) {
      print(e);
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    return data;
  }

  static Future<dynamic> dioPostCall({params, path, context, options}) async {
    Dio dio;
    Response _localResp;
    var data;

    dev.log(params is FormData ? params.fields.toString() : params.toString());
    dev.log(path.toString());

    try {
      dio = new Dio();
      _localResp = await dio.post(path, data: params, options: options);
      data = _localResp.data;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    return data;
  }

  static dynamic generateJsonParam(List<String> key, List<dynamic> params) {
    Map<String, dynamic> param = new Map();
    String jsonParam = "";
    if (params.length == key.length) {
      for (int i = 0; i < key.length; i++) {
        param[key[i]] = params[i];
      }

      jsonParam = json.encode(param);
    } else {
      return "0";
    }

    return jsonParam;
  }

  static dynamic generateMapParam(List<String> key, List<dynamic> params) {
    Map<String, dynamic> param = new Map();
    if (params.length == key.length) {
      for (int i = 0; i < key.length; i++) {
        param[key[i]] = params[i];
      }
    } else {
      return "0";
    }

    return param;
  }

  static dynamic generateJsonFromList(List<dynamic> list) {
    String jsonFromList = "";
    jsonFromList = jsonEncode(list.map((e) => e.toJson()).toList());
    return jsonFromList;
  }

  static dynamic generateDropdownMenuItem(
      {@required List childs, List values}) {
    List<DropdownMenuItem> temp = new List();
    if (childs.isNotEmpty) {
      if (values != null && childs.length == values.length) {
        int i = 0;
        childs.forEach((element) {
          temp.add(
              new DropdownMenuItem(child: Text(element), value: values[i]));
          i++;
        });
      } else {
        int i = 0;
        childs.forEach((element) {
          temp.add(new DropdownMenuItem(
            child: Text(element),
            value: i,
          ));
          i++;
        });
      }
    }
    return temp;
  }

  static const int FORMAT_DD_MM_YYYY = 1;
  static const int FORMAT_DD_MM_YYYY_HH_MM = 2;
  static const int FORMAT_YYYY_MM_DD = 3;
  static const int FORMAT_YYYY_MM_DD_HH_MM = 4;
  static const int FORMAT_MMMMM_YYYY = 5;

  static DateTime getDateTimeFromString(
      {@required targetDateTime, @required intendedFormat}) {
    DateTime dateTime;
    switch (intendedFormat) {
      case FORMAT_DD_MM_YYYY:
        var newFormat = DateFormat("dd-MM-y");
        dateTime = newFormat.parse(targetDateTime);
        break;
      case FORMAT_DD_MM_YYYY_HH_MM:
        var newFormat = DateFormat("dd-MM-y HH:mm");
        dateTime = newFormat.parse(targetDateTime);
        break;
      case FORMAT_YYYY_MM_DD:
        var newFormat = DateFormat("y-MM-dd");
        dateTime = newFormat.parse(targetDateTime);
        break;
      case FORMAT_YYYY_MM_DD_HH_MM:
        var newFormat = DateFormat("yyyy-MM-dd HH:mm");
        dateTime = newFormat.parse(targetDateTime);
        break;
      case FORMAT_MMMMM_YYYY:
        var newFormat = DateFormat("MMMM y");
        dateTime = newFormat.parse(targetDateTime);
        break;
    }

    return dateTime;
  }

  static String getStringFromDate(
      {@required targetDateTime, @required intendedFormat}) {
    String dateTime;

    switch (intendedFormat) {
      case FORMAT_DD_MM_YYYY:
        var newFormat = DateFormat("dd-MM-y");
        dateTime = newFormat.format(targetDateTime);
        break;
      case FORMAT_DD_MM_YYYY_HH_MM:
        var newFormat = DateFormat("dd-MM-y HH:mm");
        dateTime = newFormat.format(targetDateTime);
        break;
      case FORMAT_YYYY_MM_DD:
        var newFormat = DateFormat("y-MM-dd");
        dateTime = newFormat.format(targetDateTime);
        break;
      case FORMAT_YYYY_MM_DD_HH_MM:
        var newFormat = DateFormat("y-MM-dd HH:mm");
        dateTime = newFormat.format(targetDateTime);
        break;
      case FORMAT_MMMMM_YYYY:
        var newFormat = DateFormat("MMMM y");
        dateTime = newFormat.format(targetDateTime);
        break;
    }

    return dateTime;
  }

  static String formatStringDate({@required targetDateTime, @required sourceFormat, @required intendedFormat}) {
    DateTime dateTime;
    String result;

    switch (sourceFormat) {
      case FORMAT_DD_MM_YYYY:
        var newFormat = DateFormat("dd-MM-y");
        dateTime = newFormat.parse(targetDateTime);
        result = getStringFromDate(targetDateTime: dateTime, intendedFormat: intendedFormat);
        break;
      case FORMAT_DD_MM_YYYY_HH_MM:
        var newFormat = DateFormat("dd-MM-y HH:mm");
        dateTime = newFormat.parse(targetDateTime);
        result = getStringFromDate(targetDateTime: dateTime, intendedFormat: intendedFormat);
        break;
      case FORMAT_YYYY_MM_DD:
        var newFormat = DateFormat("y-MM-dd");
        dateTime = newFormat.parse(targetDateTime);
        result = getStringFromDate(targetDateTime: dateTime, intendedFormat: intendedFormat);
        break;
      case FORMAT_YYYY_MM_DD_HH_MM:
        var newFormat = DateFormat("y-MM-dd HH:mm");
        dateTime = newFormat.parse(targetDateTime);
        result = getStringFromDate(targetDateTime: dateTime, intendedFormat: intendedFormat);
        break;
      case FORMAT_MMMMM_YYYY:
        var newFormat = DateFormat("MMMM y");
        dateTime = newFormat.parse(targetDateTime);
        result = getStringFromDate(targetDateTime: dateTime, intendedFormat: intendedFormat);
        break;
    }
    return result;
  }

  static log({@required message, @required name}) {
    dev.log(message, name: name);
  }

  static navigate(context, whereTo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int idRole = prefs.get(GlobalVars.idRoleKey);
    log(message: "Role : " + idRole.toString(), name: "navigator");
    if (whereTo == 0) {
      if(idRole == 5 || idRole == 7){
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: Strings.DIALOG_MESSAGE_FORBIDDEN, context: context, popCount: 1);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
          return InventoryMain();
        }), (route) => false);
      }

    } else if (whereTo == 1) {
      if(idRole == 6 || idRole == 5 || idRole == 2 || idRole == 3 || idRole == 7){
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: Strings.DIALOG_MESSAGE_FORBIDDEN, context: context, popCount: 1);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
          return SyanaEcommerce();
        }), (route) => false);
      }

    } else if (whereTo == 2) {
      if (idRole == 4) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) {
          return SyanaHomeStarSeller();
        }), (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) {
          return SyanaHomeOwner();
        }), (route) => false);
      }
    } else if (whereTo == 3) {
      if(idRole == 5){
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: Strings.DIALOG_MESSAGE_FORBIDDEN, context: context, popCount: 1);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
          return ProductRank();
        }), (route) => false);
      }

    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
        return SyanaProfileBase();
      }), (route) => false);
    }
  }
  
  static String convertRupiah(int currency) {
    String format_currency =
        NumberFormat.currency(locale: 'id', symbol: '').format(currency);
    List<String> currencys = format_currency.split(",");
    format_currency = currencys[0];

    return format_currency;
  }
}
