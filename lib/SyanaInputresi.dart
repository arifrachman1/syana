import 'package:flutter/material.dart';
import 'package:syana/SyanaInputdatapelanggan.dart';
import 'package:syana/SyanaPenjualan.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class InputResi extends StatefulWidget {
  @override
  ResiState createState() => ResiState();
}

class ResiState extends State<InputResi> {
  List<String> toko = ['Tokopedia', 'Shoppe'];

  String selectedToko;

  void onChangedToko(value) {
    setState(() {
      this.selectedToko = value;
    });
  }

  @override
  void initState() {
    selectedToko = toko[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: inputDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedToko,
                            items: toko.map(
                              (String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: TextStyle(
                                      color: AppTheme.text_dark,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              onChangedToko(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Pilih metode input Resi',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppTheme.text_light,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: buttonWidth(context),
                        child: AspectRatio(
                          aspectRatio: buttonRatio(),
                          child: RaisedButton(
                            child: Text(
                              'MANUAL',
                            ),
                            shape: roundButton(),
                            color: AppTheme.btn_default,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return InputDataPelanggan();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: buttonWidth(context),
                        child: AspectRatio(
                          aspectRatio: buttonRatio(),
                          child: RaisedButton(
                            child: Text(
                              'OTOMATIS',
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
