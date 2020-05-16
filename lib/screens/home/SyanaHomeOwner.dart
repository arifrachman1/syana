import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/HomeOwnerController.dart';
import 'package:syana/models/HomeDataDetailModel.dart';
import 'package:syana/models/HomeDataModel.dart';
import 'package:syana/screens/promo/SyanaPromo.dart';
import 'package:syana/screens/sale/SyanaEcommerce.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import '../../main.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaHomeOwner extends StatefulWidget {
  @override
  SyanaHomeOwnerState createState() => SyanaHomeOwnerState();
}

class SyanaHomeOwnerState extends State<SyanaHomeOwner> {
  HomeOwnerController _homeOwnerController;
  HomeDataModel _homeDataModel;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _homeOwnerController = new HomeOwnerController();
    _homeOwnerController.getHomeData(context, setLoadingState, setData);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void setData(data) {
    setState(() {
      _homeDataModel = data;
    });
  }

  //komponen listview
  final int count = 3;

  var textScale;

  void logout() {
    _homeOwnerController.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: AppTheme.appBackground(),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBottomNav.getBottomNav(context, 2),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () {
                      _homeOwnerController.getHomeData(
                          context, setLoadingState, setData);
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 50.0),
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 25, bottom: 30),
                        child: Column(
                          children: <Widget>[
                            GlobalVars.isDevMode
                                ? Container(
                                    child: IconButton(
                                      onPressed: logout,
                                      icon: Icon(Icons.exit_to_app),
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: MediaQuery.of(context).size.width / 1,
                              padding: EdgeInsets.only(right: 20),
                              alignment: Alignment.topRight,
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Transform.rotate(
                                    angle: pi / 15,
                                    child: Icon(
                                      Icons.star,
                                      color: AppTheme.yellow,
                                      size: 150,
                                    ),
                                  ),
                                  Positioned(
                                    right: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "H" +
                                              (_homeDataModel != null
                                                  ? _homeDataModel.day
                                                      .toString()
                                                  : '-18'),
                                          style: TextStyle(
                                            fontSize: 27,
                                            color: AppTheme.text_light,
                                            shadows: [AppTheme.shadowText()],
                                          ),
                                        ),
                                        Text(
                                          'All-Team',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: AppTheme.text_light,
                                            shadows: [AppTheme.shadowText()],
                                          ),
                                        ),
                                        Text(
                                          _homeDataModel != null
                                              ? _homeDataModel
                                                  .allTeamPointThisMonth
                                                  .toString()
                                              : '17',
                                          style: TextStyle(
                                            fontSize: 45,
                                            color: AppTheme.text_light,
                                            shadows: [AppTheme.shadowText()],
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            _homeDataModel != null
                                                ? _homeDataModel
                                                            .allTeamPointLastMonth >
                                                        _homeDataModel
                                                            .allTeamPointThisMonth
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color: AppTheme.red)
                                                    : Icon(Icons.arrow_drop_up,
                                                        color: Colors.green)
                                                : Container(),
                                            Text(
                                              _homeDataModel != null
                                                  ? _homeDataModel
                                                      .allTeamPointLastMonth
                                                      .toString()
                                                  : '7.773',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppTheme.text_light,
                                                shadows: [
                                                  AppTheme.shadowText()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          _homeDataModel != null
                                              ? _homeDataModel
                                                  .totalPackageSentThisMonth
                                                  .toString()
                                              : '2',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Text(
                                          'Bulan ini',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    child: VerticalDivider(
                                      color: AppTheme.yellow,
                                      thickness: 2,
                                      width: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          _homeDataModel != null
                                              ? _homeDataModel
                                                  .totalPackageSentToday
                                                  .toString()
                                              : '1',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Text(
                                          'Hari ini',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                'Total paket terkirim',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.yellow,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                                bottom: 10,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          _homeDataModel != null
                                              ? _homeDataModel.grandTotalPoint
                                                  .round()
                                                  .toString()
                                              : '1',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Grand Total Poin',
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          _homeDataModel != null
                                              ? _homeDataModel.grandTotalPackage
                                                  .toString()
                                              : '1',
                                          style: TextStyle(
                                              color: AppTheme.text_light,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          'Grand Total Paket',
                                          style: TextStyle(
                                              color: AppTheme.text_light,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              alignment: Alignment.center,
                              child: RaisedButton(
                                child: Text('KONFIGURASI PROMO'),
                                color: AppTheme.yellow,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return Promo();
                                      },
                                    ),
                                  );
                                },
                                shape: AppTheme.roundButton(),
                              ),
                            ),
                            SizedBox(
                              height: ScreenSizeHelper.getDisplayHeight(
                                      context: context,
                                      which: ScreenSizeHelper
                                          .HEIGHT_WITH_STATUS_BAR) *
                                  0.5,
                              child: ListView.builder(
                                  itemCount: _homeDataModel != null ? _homeDataModel.detail.length : 0,
                                  itemBuilder: (context, index) {
                                    return list(_homeDataModel.detail[index]);
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));
  }

  // *
  // *
  // *
  // Tampilan promo

  list(HomeDataDetailModel detailModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.37,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: AppTheme.listBackground(),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 10,
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New Customers',
                    style: TextStyle(
                      color: AppTheme.text_light,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 0),
                    icon: Icon(
                      Icons.file_download,
                      color: AppTheme.text_light,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              thickness: 2,
              color: AppTheme.white,
            ),
          ),
          Flexible(
            flex: 50,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 3,
                                    child: Text(
                                      detailModel.teamName ?? 'Team Name',
                                      softWrap: true,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      detailModel.pointToday
                                              .round()
                                              .toString() ??
                                          '0',
                                      softWrap: true,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  detailModel.pointToday <
                                          detailModel.pointYesterday
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: AppTheme.red,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.green,
                                        ),
                                  Text(
                                    detailModel.pointYesterday
                                            .round()
                                            .toString() ??
                                        '0',
                                    softWrap: true,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Hari ini',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                detailModel.pointThisMonth.round().toString() ??
                                    '0',
                                softWrap: true,
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  detailModel.pointThisMonth <
                                          detailModel.pointLastMonth
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: AppTheme.red,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.green,
                                        ),
                                  Text(
                                    detailModel.pointLastMonth
                                            .round()
                                            .toString() ??
                                        '0',
                                    softWrap: true,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Bulan ini',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 30,
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Paket Hari Ini',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: Text(
                              detailModel.packageToday.toString() ?? '0',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Paket Kemarin',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: Text(
                              detailModel.packageYesterday.toString() ?? '0',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Paket Bulan Ini',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: Text(
                              detailModel.packageThisMonth.toString() ?? '0',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
