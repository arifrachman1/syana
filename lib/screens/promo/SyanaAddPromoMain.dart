import 'package:flutter/material.dart';
import 'package:syana/Controller/PromoController.dart';
import 'package:syana/models/PromoDetailModel.dart';
import 'package:syana/screens/promo/SyanaPromo.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import '../../main.dart';
import 'dart:async';
import 'package:syana/utils/AppTheme.dart';

class SyanaAddPromoMain extends StatefulWidget {
  PromoDetailModel details;
  String which, teamId;

  SyanaAddPromoMain(this.details, this.which, this.teamId);

  @override
  SyanaAddPromoMainState createState() => SyanaAddPromoMainState();
}

class SyanaAddPromoMainState extends State<SyanaAddPromoMain> {
  DateTime selectedDateMulaiPromo = DateTime.now();
  DateTime selectedDateAkhirPromo = DateTime.now();

  String _dayStart = "DD";
  String _monthStart = "MM";
  String _yearStart = "YY";

  String _dayEnd = "DD";
  String _monthEnd = "MM";
  String _yearEnd = "YY";

  PromoController _promoController;

  TextEditingController _titleController = new TextEditingController();
  String _startDate = "", _endDate = "";
  bool _isLoading = false, _isLimited = true, _isSubmitted = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _promoController = new PromoController();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

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

          _dayStart = getDay(toSplit);
          _monthStart = toSplit.split('-')[1];
          _yearStart = toSplit.split('-')[0];

          _startDate = _yearStart + "-" + _monthStart + "-" + _dayStart;
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

          _dayEnd = getDay(toSplit);
          _monthEnd = toSplit.split('-')[1];
          _yearEnd = toSplit.split('-')[0];

          _endDate = _yearEnd + "-" + _monthEnd + "-" + _dayEnd;
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: AppTheme.appBackground(),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.only(
                      top: 15.0, left: 20, right: 20, bottom: 20),
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
                                setState(() {
                                  selectedButton = value;
                                });
                                _isLimited = value == 0 ? true : false;
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
                                setState(() {
                                  selectedButton = value;
                                });
                                _isLimited = value == 0 ? true : false;
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
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0),
                                        border: InputBorder.none,
                                        hintText: 'Judul Promo',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _isLimited
                                ? Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            decoration:
                                                AppTheme.inputDecoration(),
                                            height: 50,
                                            child: Text(_dayStart +
                                                ' - ' +
                                                _monthStart +
                                                ' - ' +
                                                _yearStart),
                                          ),
                                          onTap: () {
                                            selectDateMulaiPromo(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            _isLimited
                                ? Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            decoration:
                                                AppTheme.inputDecoration(),
                                            height: 50,
                                            child: Text(_dayEnd +
                                                ' - ' +
                                                _monthEnd +
                                                ' - ' +
                                                _yearEnd),
                                          ),
                                          onTap: () {
                                            selectDateAkhirPromo(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
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
                                    if(!_isSubmitted){
                                      if (_titleController.text != "") {
                                        _promoController
                                            .setPromo(context, setLoadingState, {
                                          "title": _titleController.text,
                                          "type": widget.which,
                                          "length": _isLimited ? "1" : "2",
                                          "startDate": _startDate,
                                          "endDate": _endDate,
                                          "teamId": widget.teamId,
                                          "details": widget.details
                                        });
                                        /*we prevent multiple button click*/
                                        setState(() {
                                          _isSubmitted = true;
                                        });
                                      } else {
                                        CustomDialog.getDialog(
                                            title: Strings.DIALOG_TITLE_WARNING,
                                            message: Strings
                                                .DIALOG_MESSAGE_INSUFFICENT_PROMO_SETTING,
                                            context: context,
                                            popCount: 1);
                                      }
                                    }else{
                                      print("is already submitted!");
                                    }
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
