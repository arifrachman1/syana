import 'package:flutter/material.dart';
import 'package:syana/SyanaPenjualanTimhariini.dart';
import 'package:syana/SyanaPerincian.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class PenjualanMain extends StatefulWidget {
  @override
  PenjualanMainState createState() => PenjualanMainState();
}

class PenjualanMainState extends State<PenjualanMain> {

  List<List> penjualan = [
    ['(Better) Botanical Slimming Massage Oil', 0, 0],
    ['(Hotter) Botanical Slimming Massage Oil Carolina', 0, 0],
    ['(Kelapa) Evco Casa Di Sana', 0, 0],
    ['(Natuna) Tea Tree Essential', 0, 0],
    ['(Zaitun) Evco Casa Di Sana', 0, 0],
    ['(Zaitun) Evco Casa Di Sana', 0, 0],
    ['(Zaitun) Evco Casa Di Sana', 0, 0],
  ];

  getPenjualan(index, index2){
    var selectedPenjualan = penjualan[index];
    return selectedPenjualan[index2];
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
                        color: AppTheme.teal_light,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        getPenjualan(index, 0),
                        style: TextStyle(
                          color: AppTheme.text_light,
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
                            color: AppTheme.white,
                            size: 40,
                          ),
                          Text(getPenjualan(index, 1).toString(),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                              softWrap: true),
                          Icon(
                            Icons.expand_more,
                            color: AppTheme.white,
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
                            color: AppTheme.white,
                            size: 40,
                          ),
                          Text(getPenjualan(index, 2).toString(),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                              softWrap: true),
                          Icon(
                            Icons.expand_more,
                            color: AppTheme.white,
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
                    color: AppTheme.teal,
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
                      color: AppTheme.yellow,
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
                        color: AppTheme.text_dark,
                      ),
                    ),
                  ),
                  Container(width: 5),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.red,
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
                        color: AppTheme.text_light,
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
                backgroundColor: AppTheme.yellow,
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
                  color: AppTheme.btn_default,
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
                    style: TextStyle(
                      color: AppTheme.text_light,
                    ),
                  ),
                  shape: roundButton(),
                  color: AppTheme.btn_success,
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
