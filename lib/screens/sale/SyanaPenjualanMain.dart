import 'package:flutter/material.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaPenjualanTimhariini.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaConfirmation.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

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

  getPenjualan(index, index2) {
    var selectedPenjualan = penjualan[index];
    return selectedPenjualan[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            /*search bar*/
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: AppTheme.inputDecorationShadow(),
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
            /*label sold & free*/
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              padding: EdgeInsets.only(left: 10, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
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
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: AspectRatio(
                      aspectRatio: 2.5 / 1,
                      child: Center(
                        child: Text(
                          'Terjual',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.text_dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Container(
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
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: AspectRatio(
                      aspectRatio: 2.5 / 1,
                      child: Center(
                        child: Text(
                          'Free',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.text_light,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        /*item*/
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: penjualan.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: AppTheme.listBackground(),
                  height: Dimens.listHeight(context),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: AppTheme.teal_light,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 49,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            getPenjualan(index, 0),
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 15,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        /*bottom buttons */
        Container(
          margin: EdgeInsets.only(
            bottom: 12,
            right: 5,
            left: 5,
          ),
          child: Row(
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
              Container(
                width: Dimens.buttonWidth(context),
                child: AspectRatio(
                  aspectRatio: Dimens.buttonRatio(),
                  child: RaisedButton(
                    child: Text(
                      'KEMBALI',
                    ),
                    shape: AppTheme.roundButton(),
                    color: AppTheme.btn_default,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Container(
                width: Dimens.buttonWidth(context),
                child: AspectRatio(
                  aspectRatio: Dimens.buttonRatio(),
                  child: RaisedButton(
                    child: Text(
                      'LANJUT',
                      style: TextStyle(
                        color: AppTheme.text_light,
                      ),
                    ),
                    shape: AppTheme.roundButton(),
                    color: AppTheme.btn_success,
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Perincian();
                          },
                        ),
                      );*/
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
