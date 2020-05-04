import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/UserModel.dart';
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
    try {
      dio = new Dio();
      _localResp =
          await dio.get(path, options: options, queryParameters: params);
      data = _localResp.data;
    } on DioError catch (e) {
      print(e.response.data.toString());
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
    try {
      dio = new Dio();
      _localResp = await dio.post(path, data: params, options: options);
      data = _localResp.data;
    } on DioError catch (e) {
      print(e.response.data.toString());
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

  static dynamic generateMapParam(List<String> key, List<dynamic> params){
    Map<String, dynamic> param = new Map();
    if(params.length == key.length){
      for(int i = 0; i < key.length; i ++){
        param[key[i]] = params[i];
      }
    }else{
      return "0";
    }

    return param;
  }
}
