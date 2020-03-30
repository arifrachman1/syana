import 'package:flutter/material.dart';
import 'package:syana/SyanaPenjualanTimhariini.dart';
import 'package:syana/SyanaPerincian.dart';
import './main.dart';

class PenjualanMain extends StatefulWidget {
  @override
  PenjualanMainState createState() => PenjualanMainState();
}

class PenjualanMainState extends State<PenjualanMain> {
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
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60, bottom: 75),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: penjualan.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: listBackground(),
                height: 110,
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 70,
                      child: Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.teal[200],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '(Better) Botanical Slimming Message Oil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.expand_less,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text('0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              softWrap: true),
                          Icon(
                            Icons.expand_more,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.expand_less,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text('0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              softWrap: true),
                          Icon(
                            Icons.expand_more,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
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
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 10, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.yellow[400],
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 3,
                          spreadRadius: 3 / 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    width: 65,
                    height: 25,
                    child: Text(
                      'Terjual',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(width: 5),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 3,
                          spreadRadius: 3 / 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    width: 65,
                    height: 25,
                    child: Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12, right: 10, left: 10),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.yellow[400],
                foregroundColor: Colors.black,
                tooltip: 'Add',
                child: Icon(
                  Icons.playlist_add_check,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return PenjualanTimHariIni();
                      },
                    ),
                  );
                },
              ),
              Container(width: 20),
              ButtonTheme(
                minWidth: 130,
                child: RaisedButton(
                  child: Text(
                    'KEMBALI',
                  ),
                  shape: roundButton(),
                  color: Colors.grey[200],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 130,
                child: RaisedButton(
                  child: Text(
                    'LANJUT',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: roundButton(),
                  color: Colors.green[400],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Perincian();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
