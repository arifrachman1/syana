import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/TripsModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/credentials/Login.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class ProfileController {
  UserModel _userModel;

  ProfileController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getPersonalInfo(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();

    DateTime _joinDate,
            _now = new DateTime(DateTime
                    .now()
                    .year, DateTime
                    .now()
                    .month),
            _diffDate;

    _joinDate = GlobalFunctions.getDateTimeFromString(targetDateTime: _userModel.dateTimeJoined, intendedFormat: GlobalFunctions.FORMAT_YYYY_MM_DD);

    int _yearDiff = _now.year - _joinDate.year, _montDiff = 0;
    if (_joinDate.month > _now.month) {
      _yearDiff--;
      _montDiff = _now.month + (12 - _joinDate.month);
    } else {
      _montDiff = _now.month - _joinDate.month;
    }

    _diffDate = new DateTime(_yearDiff, _montDiff);

    Map returnValues = new Map();

    returnValues['fullName'] = _userModel.fullName;
    returnValues['joinDate'] = _joinDate;
    returnValues['diffDate'] = _diffDate;

    loadingStateCallback();

    setDataCallback(returnValues);
  }

  getMyPoints(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    Map myPoints = new Map();

    loadingStateCallback();
    var params = GlobalFunctions.generateMapParam(['id_employee'], [_userModel.id]);
    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-my-points", params: params, context: context);

    if (data != null) {
      if (data['status'] == 1) {
        myPoints['pointsThisMonth'] = data['pointsThisMonth'];
        myPoints['pointsThreeMonthsPrior'] = data['pointsThreeMonthsPrior'];
        myPoints['packagesThisMonth'] = data['packagesThisMonth'];
        myPoints['packagesThreeMonthsPrior'] = data['packagesThreeMonthsPrior'];

        setDataCallback(myPoints);
      }
    }
    loadingStateCallback();
  }

  getTrips(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();

    var params = GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);
    final data = await GlobalFunctions.dioGetCall(context: context, path: GlobalVars.apiUrl + "get-syana-trip", params: params);
    if (data != null) {
      if (data['status'] == 1) {
        List tripsFromApi = data['favourite'];
        List<TripsModel> favouriteTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            favouriteTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['newest'];
        List<TripsModel> newestTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            newestTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['top_3'];
        List<TripsModel> topThreeTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            topThreeTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        tripsFromApi = data['rest'];
        List<TripsModel> otherTrips = new List();

        if (tripsFromApi != null || tripsFromApi.isNotEmpty) {
          tripsFromApi.forEach((element) {
            otherTrips.add(new TripsModel.init(
                element['id'].toString(),
                element['title'].toString(),
                element['quote'].toString(),
                element['youtube_link'].toString(),
                element['view_number'].toString(),
                element['thumbnail'].toString(),
                element['description'].toString()));
          });
        }

        Map returnValues = new Map();

        returnValues['favouriteTrips'] = favouriteTrips;
        returnValues['newestTrips'] = newestTrips;
        returnValues['topThreeTrips'] = topThreeTrips;
        returnValues['otherTrips'] = otherTrips;

        setDataCallback(returnValues);
      }
    }
    loadingStateCallback();
  }

  changePassword(context, loadingStateCallBack, oldPassword, newPassword) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallBack();

    var params =
    GlobalFunctions.generateMapParam(["id_employee", "password_old", "password_new"], [_userModel.id.toString(), oldPassword, newPassword]);

    FormData formData = FormData.fromMap(params);

    final data = await GlobalFunctions.dioPostCall(context: context, path: GlobalVars.apiUrl + "change-password", params: formData);

    if (data != null) {
      if (data['status'] == 1) {
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_SUCCESS, message: Strings.DIALOG_MESSAGE_PASSWORD_CHANGED, context: context, popCount: 2);
      }
    }

    loadingStateCallBack();
  }

  logout(context, setLoadingState) async {
    setLoadingState();
    _userModel = await GlobalFunctions.getPersistence();

    Map params = GlobalFunctions.generateMapParam(['employee_id'], [_userModel.id]);

    final data = await GlobalFunctions.dioPostCall(context: context, path: GlobalVars.apiUrl + "logout", params: params);

    if (data != null) {
      if (data['status'] == 200) {
        await clearPersistence();

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
          return Login();
        }), (route) => false);
      } else {
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: data['message'], context: context, popCount: 1);
      }
    } else {
      CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: "Proses logout gagal.", context: context, popCount: 1);
    }
    setLoadingState();
  }

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
}
