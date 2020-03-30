import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syana/SyanaInputdatapelanggan.dart';
import 'package:syana/SyanaInputresi.dart';
import 'package:syana/SyanaPenjualan.dart';
import 'package:syana/SyanaPenjualanTimhariini.dart';
import 'package:syana/SyanaProductRank.dart';
import 'package:syana/SyanaPromo.dart';
import 'package:syana/SyanaStok.dart';
import './main.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //page komponen bottom navigation bar
  final pages = [
    Stok(),
    InputResi(),
    HomePage(),
    ProductRank(),
    HomePage(),
  ];

  int selectedIndex = 2;

  void onTapBottom(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dns),
            title: Text('Stok'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Penjualan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Grafik'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Akun'),
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        // fixedColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.teal[700],
        unselectedItemColor: Colors.teal[200],
        onTap: onTapBottom,
      ),
      body: pages.elementAt(selectedIndex),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //komponen listview
  final int count = 3;
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
      // padding: EdgeInsets.only(bottom: 10),
      decoration: background(),
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
                      child: Icon(Icons.star,
                          color: Colors.yellow[400], size: 150),
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
                              color: Colors.white,
                              shadows: [shadowText()],
                            ),
                          ),
                          Text(
                            'All-Team',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              shadows: [shadowText()],
                            ),
                          ),
                          Text(
                            '17',
                            style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                              shadows: [shadowText()],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.arrow_drop_down, color: Colors.red),
                              Text(
                                '7.773',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
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
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          Text(
                            'Bulan ini',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: VerticalDivider(
                        color: Colors.yellow,
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
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          Text(
                            'Hari ini',
                            style: TextStyle(
                              color: Colors.white,
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
                    color: Colors.yellow,
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
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Grand Total Poin',
                            style: TextStyle(
                              color: Colors.white,
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
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            'Grand Total Paket',
                            style: TextStyle(color: Colors.white, fontSize: 15),
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
                  color: Colors.yellow[300],
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
              list(),
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
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 0),
                    icon: Icon(
                      Icons.file_download,
                      color: Colors.white,
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
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '0',
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
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
                                  color: Colors.red,
                                ),
                                onPressed: null,
                              ),
                              Text(
                                '0',
                                softWrap: true,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                                  color: Colors.red,
                                ),
                                onPressed: null,
                              ),
                              Text(
                                '0',
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
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
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
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
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
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
