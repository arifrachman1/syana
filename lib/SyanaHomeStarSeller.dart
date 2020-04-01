import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'SyanaPromo.dart';
import 'main.dart';
import 'utils/AppTheme.dart';

class SyanaHomeStarSeller extends StatefulWidget {
  @override
  _SyanaHomeStarSellerState createState() => _SyanaHomeStarSellerState();
}

class _SyanaHomeStarSellerState extends State<SyanaHomeStarSeller> {

  //komponen listview
  final int count = 1;
  List<bool> penjualan = List<bool>();

  @override
  void initState() {
    setState(() {
      for (var i = 0; i < this.count; i++) {
        penjualan.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: appBackground(),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 30),
          child: Column(
            children: <Widget>[
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'H-18',
                            style: TextStyle(
                              fontSize: 27,
                              color: AppTheme.text_light,
                              shadows: [shadowText()],
                            ),
                          ),
                          Text(
                            'All-Team',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppTheme.text_light,
                              shadows: [shadowText()],
                            ),
                          ),
                          Text(
                            '17',
                            style: TextStyle(
                              fontSize: 45,
                              color: AppTheme.text_light,
                              shadows: [shadowText()],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.arrow_drop_down, color: AppTheme.red),
                              Text(
                                '7.773',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.text_light,
                                  shadows: [shadowText()],
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '2',
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
                            '1',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '138922',
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
                            '138922',
                            style: TextStyle(
                                color: AppTheme.text_light, fontSize: 17),
                          ),
                          Text(
                            'Grand Total Paket',
                            style: TextStyle(
                                color: AppTheme.text_light, fontSize: 15),
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
                  shape: roundButton(),
                ),
              ),
              list(),
              
            ],
          ),
        ),
      ),
    );
  }
   // *
  // *
  // *
  // Tampilan promo

  list() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.37,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: listBackground(),
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
                                      'Healthy Noona',
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
                                  IconButton(
                                    padding: EdgeInsets.only(top: 0),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: AppTheme.red,
                                    ),
                                    onPressed: null,
                                  ),
                                  Text(
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
                                  IconButton(
                                    padding: EdgeInsets.only(top: 0),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: AppTheme.red,
                                    ),
                                    onPressed: null,
                                  ),
                                  Text(
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
                              '0',
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
                              '0',
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
                              '0',
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