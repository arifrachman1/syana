import 'package:flutter/material.dart';
import './main.dart';

class PenjualanTimHariIni extends StatefulWidget {
  @override
  PenjualanState createState() => PenjualanState();
}

class PenjualanState extends State<PenjualanTimHariIni> {
  final int count = 7;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Penjualan Tim Hari Ini'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: background(),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: penjualan.length,
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
                            'Shoppe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, top: 7),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '8819912058031444',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7, bottom: 7),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '2020-03-13 13:27:07',
                            style: TextStyle(
                              color: Colors.white,
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
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
