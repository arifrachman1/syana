import 'package:flutter/material.dart';
import 'package:syana/screens/promo/SyanaPromo.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';
import 'dart:async';
import 'package:syana/utils/AppTheme.dart';

class TambahpromobaruSelanjutnya extends StatefulWidget {
  @override
  TambahSelanjutnyaState createState() => TambahSelanjutnyaState();
}

class TambahSelanjutnyaState extends State<TambahpromobaruSelanjutnya> {
  DateTime selectedDateMulaiPromo = DateTime.now();
  DateTime selectedDateAkhirPromo = DateTime.now();

  String dayMulaiPromo = "DD";
  String monthMulaiPromo = "MM";
  String yearMulaiPromo = "YY";

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
      setState(
        () {
          selectedDateMulaiPromo = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayMulaiPromo = getDay(toSplit);
          monthMulaiPromo = toSplit.split('-')[1];
          yearMulaiPromo = toSplit.split('-')[0];
        },
      );
  }

  Future<Null> selectDateAkhirPromo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateAkhirPromo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateAkhirPromo)
      setState(
        () {
          selectedDateAkhirPromo = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayAkhirPromo = getDay(toSplit);
          monthAkhirPromo = toSplit.split('-')[1];
          yearAkhirPromo = toSplit.split('-')[0];
        },
      );
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
        decoration: AppTheme.appBackground(),
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
                      color: AppTheme.text_light,
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
                        activeColor: AppTheme.yellow,
                        value: 0,
                        groupValue: this.selectedButton,
                        onChanged: (int value) {
                          onChangedButton(value);
                        },
                      ),
                      Text(
                        'Limited Time',
                        style: TextStyle(
                          color: AppTheme.text_light,
                        ),
                      ),
                      Radio(
                        activeColor: AppTheme.yellow,
                        value: 1,
                        groupValue: this.selectedButton,
                        onChanged: (int value) {
                          onChangedButton(value);
                        },
                      ),
                      Text(
                        'Lifetime',
                        style: TextStyle(
                          color: AppTheme.text_light,
                        ),
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
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: AppTheme.inputDecoration(),
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
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                decoration: AppTheme.inputDecoration(),
                                height: 50,
                                child: Text(dayMulaiPromo +
                                    ' - ' +
                                    monthMulaiPromo +
                                    ' - ' +
                                    yearMulaiPromo),
                              ),
                              onTap: () {
                                selectDateMulaiPromo(context);
                              },
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
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                decoration: AppTheme.inputDecoration(),
                                height: 50,
                                child: Text(dayAkhirPromo +
                                    ' - ' +
                                    monthAkhirPromo +
                                    ' - ' +
                                    yearAkhirPromo),
                              ),
                              onTap: () {
                                selectDateAkhirPromo(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: Dimens.buttonWidthWide(context),
                        child: AspectRatio(
                          aspectRatio: Dimens.buttonRatioWide(),
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
                        width: Dimens.buttonWidthWide(context),
                        child: AspectRatio(
                          aspectRatio: Dimens.buttonRatioWide(),
                          child: RaisedButton(
                            child: Text(
                              'SELANJUTNYA',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                            ),
                            shape: AppTheme.roundButton(),
                            color: AppTheme.btn_success,
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
