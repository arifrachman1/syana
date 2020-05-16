import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/home/SyanaHomeOwner.dart';
import 'package:syana/screens/home/SyanaHomeStarSeller.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class LoginController {
  BuildContext context;
  UserModel _userModel;
  
  void savePersistence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(GlobalVars.idKey, _userModel.id);
    prefs.setString(GlobalVars.nameKey, _userModel.name);
    prefs.setString(GlobalVars.fullNameKey, _userModel.fullName);
    prefs.setString(GlobalVars.dateTimeJoinedKey, _userModel.dateTimeJoined);
    prefs.setInt(GlobalVars.idRoleKey, _userModel.idRole);
    prefs.setInt(GlobalVars.idTeamKey, _userModel.idTeam);
    prefs.setString(GlobalVars.accessTokenKey, _userModel.accessToken);
  }

  void login(context, loadingStateCallback, username, password) async {
    FormData formData =
        FormData.fromMap({"username": username, "password": password});

    loadingStateCallback();
    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.apiUrl + "login", params: formData, context: context);

    if (data != null) {
      if (data['status'] == 1) {
        _userModel = new UserModel(
            data['id'],
            data['name'],
            data['full_name'],
            data['datetime_joined'],
            data['id_role'],
            data['id_team'],
            data['access_token']);

        await savePersistence();

        //redirect
        if(_userModel.idRole == 4){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
            return SyanaHomeStarSeller();
          }));
        }else if(_userModel.idRole == 2 || _userModel.idRole == 1){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
            return SyanaHomeOwner();
          }));
        }
      }
    }
  }
}
