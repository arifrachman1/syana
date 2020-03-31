import 'package:flutter/material.dart';
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
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: listBackground(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 3),
              height: 20,
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
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Divider(
                thickness: 2,
                color: AppTheme.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Healthy Noona',
                                softWrap: true,
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.right,
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
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
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hari ini',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          height: 75,
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
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
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Bulan ini',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Column(
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
                  Container(
                    width: 80,
                    child: Column(
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
                  Container(
                    width: 80,
                    child: Column(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}