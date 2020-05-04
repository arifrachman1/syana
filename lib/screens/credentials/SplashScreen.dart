import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/screens/credentials/Login.dart';
import 'package:syana/screens/home/SyanaHomeOwner.dart';
import 'package:syana/screens/home/SyanaHomeStarSeller.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  _startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int idRole = prefs.get(GlobalVars.idRoleKey);
      if (idRole != null) {
        if (idRole == 4) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return SyanaHomeStarSeller();
          }));
        } else if (idRole == 2 || idRole == 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return SyanaHomeOwner();
          }));
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Login();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/splashscreen.png",
        width: ScreenSizeHelper.getDisplayWidth(context),
        height: ScreenSizeHelper.getDisplayHeight(
            context: context, which: ScreenSizeHelper.HIEGHT_FULL),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
