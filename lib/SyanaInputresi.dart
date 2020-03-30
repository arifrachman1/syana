import 'package:flutter/material.dart';
import 'package:syana/SyanaInputdatapelanggan.dart';
import 'package:syana/SyanaPenjualan.dart';
import './main.dart';

class InputResi extends StatefulWidget {
  @override
  ResiState createState() => ResiState();
}

class ResiState extends State<InputResi> {
  List<String> toko = ['Tokopedia', 'Shoppe'];

  String tokoItem = 'Tokopedia';

  void onChangedToko(value) {
    setState(() {
      this.tokoItem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: background(),
          height: MediaQuery.of(context).size.height,
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
                            value: tokoItem,
                            items: toko.map(
                              (String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: TextStyle(
                                      color: Colors.black54,
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
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 150,
                        height: 45,
                        child: RaisedButton(
                          child: Text(
                            'MANUAL',
                          ),
                          shape: roundButton(),
                          color: Colors.grey[200],
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
                      Expanded(
                        child: Container(),
                      ),
                      ButtonTheme(
                        minWidth: 150,
                        height: 45,
                        child: RaisedButton(
                          child: Text('OTOMATIS'),
                          shape: roundButton(),
                          color: Colors.green[400],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}