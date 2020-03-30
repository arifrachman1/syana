import 'package:flutter/material.dart';
import 'package:syana/SyanaPenjualan.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';


class InputDataPelanggan extends StatefulWidget {
  @override
  MasukkanState createState() => MasukkanState();
}

class MasukkanState extends State<InputDataPelanggan> {
  int selectedButton = 0;

  void onChangedButton(int value) {
    setState(() {
      this.selectedButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: appBackground(),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding:
                EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Masukkan data pelanggan',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.text_light,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        decoration: inputDecoration(),
                        child: TextField(
                          decoration: textFieldDecoration('2147483647'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        decoration: inputDecoration(),
                        child: TextField(
                          decoration: textFieldDecoration('Irvan Sembarany'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        decoration: inputDecoration(),
                        child: TextField(
                          decoration: textFieldDecoration('26171'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150,
                        height: 45,
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
                      Expanded(
                        child: Container(),
                      ),
                      ButtonTheme(
                        minWidth: 150,
                        height: 45,
                        child: RaisedButton(
                          child: Text(
                            'SIMPAN',
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
                                  return Penjualan();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
