import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syana/Controller/HomeOwnerController.dart';
import 'package:syana/Controller/ProfileController.dart';
import 'package:syana/DefaultView.dart';
import 'package:syana/screens/profile/SyanaChangePassword.dart';
import 'package:syana/screens/profile/SyanaShortcutSettings.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/widgets/CustomBottomNav.dart';

class SyanaProfile extends StatefulWidget {
  @override
  SyanaProfileState createState() => SyanaProfileState();
}

class SyanaProfileState extends DefaultView<SyanaProfile> {
  ProfileController _profileController;
  Map _personalInfo = new Map();
  HomeOwnerController _homeOwnerController;

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileController = new ProfileController();

    _initData();
  }

  _initData() async {
    await _profileController.getPersonalInfo(context, setLoadingState, setData);
  }

  @override
  void setLoadingState() {
    if (this.mounted) {
      setState(() {
        _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
      });
    }
  }

  @override
  void setData(data) {
    if (data is Map) {
      setState(() {
        _personalInfo = data;
        print(_personalInfo);
      });
    }
  }

  void logout() {
    log("button pressed");
    _profileController.logout(context, setLoadingState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 4),
      body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.bottomRight,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: IconButton(
                          icon: Icon(
                            Icons.lock_outline,
                            size: 35,
                            color: AppTheme.white,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                              return SyanaChangePassword();
                            }));
                          },
                        )),
                Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.bottomRight,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                              return ShortcutSettings();
                            }));
                          },
                          icon: Icon(
                            Icons.launch,
                            size: 35,
                            color: AppTheme.white,
                          ),
                        )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: IconButton(
                    onPressed: logout,
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 35,
                    ),
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Hi, ' + _personalInfo['fullName'],
                      style: TextStyle(
                        color: AppTheme.text_light,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Anda bergabung pada ' +
                              GlobalFunctions.getStringFromDate(
                                      targetDateTime: _personalInfo['joinDate'],
                                      intendedFormat:
                                      GlobalFunctions.FORMAT_MMMMM_YYYY),
                      style: TextStyle(
                        color: AppTheme.text_light,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Anda telah bekerja selama ' +
                              _personalInfo['diffDate'].year.toString() +
                              ' Tahun ' +
                              _personalInfo['diffDate'].month.toString() +
                              ' Bulan',
                      style: TextStyle(
                        color: AppTheme.text_light,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Semangat ya! ',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 17,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: AppTheme.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
