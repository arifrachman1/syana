import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/HomeDataDetailModel.dart';
import 'package:syana/models/HomeDataModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/credentials/Login.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class HomeOwnerController {
  UserModel _userModel;

  clearPersistence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(GlobalVars.idKey);
    prefs.remove(GlobalVars.nameKey);
    prefs.remove(GlobalVars.fullNameKey);
    prefs.remove(GlobalVars.dateTimeJoinedKey);
    prefs.remove(GlobalVars.idRoleKey);
    prefs.remove(GlobalVars.idTeamKey);
    prefs.remove(GlobalVars.accessTokenKey);
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  logout(context) async {
    await clearPersistence();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
      return Login();
    }), (route) => false);
  }

  getUserModel() async {
    if (_userModel == null) {
      await _getPersistence();
    }

    return _userModel;
  }

  getHomeData(context, loadingStateCallback, setDataCallback) async {
    await _getPersistence();
    var params = GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);
    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-home-info", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List _detailFromApi = data['each_team_point'];
        List<HomeDataDetailModel> details = new List();
        _detailFromApi.forEach((element) {
          details.add(new HomeDataDetailModel(
                  element['id_team'].toString(),
              element['package_today'].toString(),
              element['package_yesterday'].toString(),
              element['package_this_month'].toString(),
              element['point_this_month'].toString(),
              element['point_last_month'].toString(),
              element['point_today'].toString(),
              element['point_yesterday'].toString(),
              element['name_team'] ?? "",
              element['package_last_month'].toString()));

          log(details.last.toString(), name: "log-status-result");
        });

        details.sort((a, b) => int.parse(b.packageToday.toString()).compareTo(int.parse(a.packageToday.toString())));

        HomeDataModel homeDataModel = new HomeDataModel.Owner(
            data['day'].toString(),
            data['total_packet_sent_today'].toString(),
            data['total_packet_sent_this_month'].toString(),
            data['product_sold_today'].toString(),
            data['product_sold_yesterday'].toString(),
            data['product_sold_this_month'].toString(),
            data['product_sold_last_month'].toString(),
            data['all_team_point_this_month'].toString(),
            data['all_team_point_last_month'].toString(),
            data['grand_total_point'].toString(),
            data['grand_total_package'].toString(),
            data['grand_total_point_team'].toString(),
            data['grand_total_package_team'].toString(),
            details);

        log(homeDataModel.toString(), name: "home-info");

        setDataCallback(homeDataModel);
      }
    } else {
      CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: Strings.DIALOG_MESSAGE_API_CALL_FAILED, context: context, popCount: 1);
    }
    loadingStateCallback();
  }

/*sortBySentPackage(HomeDataModel data) {
    data.detail.sort();

    data.detail.forEach((element) {
      dev.log(element.toString(), name: _devTitle);
    });

    return data;
  }*/
}
