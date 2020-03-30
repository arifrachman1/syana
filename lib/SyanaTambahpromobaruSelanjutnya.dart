import 'package:flutter/material.dart';
import 'package:syana/SyanaPromo.dart';
import './main.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TambahpromobaruSelanjutnya extends StatefulWidget {
  @override
  TambahSelanjutnyaState createState() => TambahSelanjutnyaState();
}

class TambahSelanjutnyaState extends State<TambahpromobaruSelanjutnya> {
  DateTime selectedDateMulaiPromo = DateTime.now();
  DateTime selectedDateAkhirPromo = DateTime.now();

  String dayAwalPromo = "DD";
  String monthAwalPromo = "MM";
  String yearAwalPromo = "YY";

  String dayAkhirPromo = "DD";
  String monthAkhirPromo = "MM";
  String yearAkhirPromo = "YY";

  Future<Null> selectDateMulaiPromo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateMulaiPromo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateMulaiPromo)
      setState(() {
        selectedDateMulaiPromo = picked;
        var tes = picked.toString();
        getDay(val) {
          String dayTime = val.split('-')[2];
          String day = dayTime.split(' ')[0];
          return day;
        }

        ;
        dayAwalPromo = getDay(tes);
        monthAwalPromo = tes.split('-')[1];
        yearAwalPromo = tes.split('-')[0];
      });
  }

  Future<Null> selectDateAkhirPromo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateAkhirPromo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateAkhirPromo)
      setState(() {
        selectedDateAkhirPromo = picked;
        var tes = picked.toString();
        getDay(val) {
          String dayTime = val.split('-')[2];
          String day = dayTime.split(' ')[0];
          return day;
        }

        ;
        dayAkhirPromo = getDay(tes);
        monthAkhirPromo = tes.split('-')[1];
        yearAkhirPromo = tes.split('-')[0];
      });
  }

  // =====================================
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
        decoration: background(),
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
                    'Tambahkan Promo Baru',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        activeColor: Colors.yellow[400],
                        value: 0,
                        groupValue: this.selectedButton,
                        onChanged: (int value) {
                          onChangedButton(value);
                        },
                      ),
                      Text(
                        'Limited Time',
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio(
                        activeColor: Colors.yellow[400],
                        value: 1,
                        groupValue: this.selectedButton,
                        onChanged: (int value) {
                          onChangedButton(value);
                        },
                      ),
                      Text(
                        'Lifetime',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Judul Promo :',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: inputDecoration(),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.0),
                                  border: InputBorder.none,
                                  hintText: 'Judul Promo',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tanggal Mulai Promo :',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 10),
                              decoration: inputDecoration(),
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                color: Colors.white,
                                elevation: 0.0,
                                shape: roundButton(),
                                onPressed: () => selectDateMulaiPromo(context),
                                child: Text(dayAwalPromo +
                                    ' - ' +
                                    monthAwalPromo +
                                    ' - ' +
                                    yearAwalPromo),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tanggal Akhir Promo :',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 10),
                              decoration: inputDecoration(),
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                color: Colors.white,
                                elevation: 0.0,
                                shape: roundButton(),
                                onPressed: () => selectDateAkhirPromo(context),
                                child: Text(dayAkhirPromo +
                                    ' - ' +
                                    monthAkhirPromo +
                                    ' - ' +
                                    yearAkhirPromo),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.only(top: 60),
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
                          color: Colors.grey[200],
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
                            'SELANJUTNYA',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: roundButton(),
                          color: Colors.green[400],
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
