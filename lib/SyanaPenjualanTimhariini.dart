import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class PenjualanTimHariIni extends StatefulWidget {
  @override
  PenjualanState createState() => PenjualanState();
}

class PenjualanState extends State<PenjualanTimHariIni> {
  List<List> penjualanTim = [
    ['Shoppe', '8819912058031444', '2020-03-13 13:27:07'],
    ['Shoppe', '8819912058031445', '2020-03-13 13:27:08'],
    ['Shoppe', '8819912058031446', '2020-03-13 13:27:09'],
  ];

  getPenjualanTim(index, index2) {
    var selectedPenjualanTim = penjualanTim[index];
    return selectedPenjualanTim[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Penjualan Tim Hari Ini'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: appBackground(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 10),
              decoration: inputDecorationShadow(),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cari Produk',
                  icon: Icon(
                    Icons.search,
                    color: AppTheme.teal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: penjualanTim.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 110,
                      decoration: listBackground(),
                      margin: EdgeInsets.only(top: 7, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 10, left: 7),
                            child: Text(
                              getPenjualanTim(index, 0),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7, top: 7),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getPenjualanTim(index, 1),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7, bottom: 7),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getPenjualanTim(index, 2),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
