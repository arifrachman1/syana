import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/controller/RankDataController.dart';
import 'package:syana/models/SummaryModel.dart';
import 'package:syana/screens/product_rank/SyanaSummaryDetail.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';

class SyanaSummary extends StatefulWidget {
  @override
  _SyanaSummaryState createState() => _SyanaSummaryState();
}

class _SyanaSummaryState extends State<SyanaSummary> {
  bool _isLoading = false;

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  DateFormat formatDate = DateFormat("yyyy-MM-dd");

  String dayFrom = "DD";
  String monthFrom = "MM";
  String yearFrom = "YY";

  String dayTo = "DD";
  String monthTo = "MM";
  String yearTo = "YY";
  String _dateFrom = "";
  String _dateTo = "";

  RankDataController _rankDataController;

  List<DropdownMenuItem> _listOfTeams = new List();
  List<DropdownMenuItem> _listOfEcommerce = new List();

  List<SummaryModel> _list = new List();
  int _selectedteam, _selectedEcommerce;

  Future<Null> selectDateFrom(BuildContext context) async {
    final DateTime picked =
    await showDatePicker(context: context, initialDate: selectedDateFrom, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateFrom)
      setState(
                () {
          selectedDateFrom = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayFrom = getDay(toSplit);
          monthFrom = toSplit.split('-')[1];
          yearFrom = toSplit.split('-')[0];
        },
      );
    _dateFrom = formatDate.format(selectedDateFrom);
    if (_dateFrom != "" && _dateTo != "") {
      _list.clear();
      setLoadingState();
      await _rankDataController.getSummary(context, setData, setLoadingState, _selectedteam, _selectedEcommerce, _currentTimes, _dateFrom, _dateTo);
      setLoadingState();
    }
  }

  Future<Null> selectDateTo(BuildContext context) async {
    final DateTime picked =
    await showDatePicker(context: context, initialDate: selectedDateTo, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTo)
      setState(
                () {
          selectedDateTo = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayTo = getDay(toSplit);
          monthTo = toSplit.split('-')[1];
          yearTo = toSplit.split('-')[0];
        },
      );
    _dateTo = formatDate.format(selectedDateTo);
    if (_dateFrom != "" && _dateTo != "") {
      _list.clear();
      setLoadingState();
      await _rankDataController.getSummary(context, setData, setLoadingState, _selectedteam, _selectedEcommerce, _currentTimes, _dateFrom, _dateTo);
      setLoadingState();
    }
  }

  showsDatePicker(index) {
    if (index == 7) {
      return Container(
        padding: EdgeInsets.only(left: 10),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: Dimens.margin_m, vertical: Dimens.margin_s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'From',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      // margin: EdgeInsets.only(top: 10),
                      // padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.dateDecorationShadow(),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: AppTheme.white,
                          ),
                          Text(
                            dayFrom + ' - ' + monthFrom + ' - ' + yearFrom,
                            style: TextStyle(color: AppTheme.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectDateFrom(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.03,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'To',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: AppTheme.dateDecorationShadow(),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: AppTheme.white,
                          ),
                          Text(
                            dayTo + ' - ' + monthTo + ' - ' + yearTo,
                            style: TextStyle(color: AppTheme.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectDateTo(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void setLoadingState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rankDataController = new RankDataController();
    _init();
  }

  setData(data) {
    log("data received\n${data.toString()}");

    if (data is Map) {
      switch (data['key']) {
        case RankDataKey.teamWithSummary:
          setState(() {
            _listOfTeams = data['payload'];
            _selectedteam = _listOfTeams[0].value;
          });
          _rankDataController.getEcommerceWithSummary(context, setData, setLoadingState, _selectedteam);
          break;
        case RankDataKey.ecommerceWithSummary:
          setState(() {
            _listOfEcommerce = data['payload'];
            _selectedEcommerce = _listOfEcommerce[0].value;
          });
          _rankDataController.getSummary(context, setData, setLoadingState, _selectedteam, _selectedEcommerce, "0", "", "");
          break;
        case RankDataKey.summary:
          setState(() {
            _list = data['payload'];
          });
          break;
      }
    }
  }

  _init() async {
    await _rankDataController.getTeamsWithSummary(context, setData, setLoadingState);
  }

  String _selectedTime = "Hari ini";
  String _currentTimes = "0";

  List<String> waktu = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Minggu lalu',
    'Bulan lalu',
    'Grand Total',
    'Tentukan sendiri'
  ];

  String getFilterTime(String filterTime) {
    String filterTemp = "";
    if (filterTime == "Hari ini") {
      filterTemp = "0";
    } else if (filterTime == "Minggu ini") {
      filterTemp = "1";
    } else if (filterTime == "Bulan ini") {
      filterTemp = "2";
    } else if (filterTime == "Minggu lalu") {
      filterTemp = "3";
    } else if (filterTime == "Bulan lalu") {
      filterTemp = "4";
    } else if (filterTime == "Grand Total") {
      filterTemp = "5";
    } else if (filterTime == "Tentukan sendiri") {
      filterTemp = "6";
    }
    return filterTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.appBackground(),
      child: _isLoading
              ? Center(
        child: CircularProgressIndicator(),
      )
              : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_m, vertical: Dimens.margin_s),
            decoration: AppTheme.inputDecorationShadow(),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(),
                // padding: EdgeInsets.only(left: 10),
                //decoration: AppTheme.inputDecorationShadow(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedteam,
                    items: _listOfTeams,
                    onChanged: (item) {
                      setState(() {
                        _selectedteam = item;
                      });
                      _rankDataController.getEcommerceWithSummary(context, setData, setLoadingState, item);
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_m, vertical: Dimens.margin_s),
            decoration: AppTheme.inputDecorationShadow(),
            child: Expanded(
              child: Container(
                // width: 150,
                //padding: EdgeInsets.only(left: 10),
                //decoration: AppTheme.inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectedEcommerce,
                          items: _listOfEcommerce,
                          onChanged: (item) {
                            if (_selectedteam != null) {
                              setState(() {
                                _selectedEcommerce = item;
                              });
                              _rankDataController
                                      .getSummary(context, setData, setLoadingState, _selectedteam, item, _currentTimes, _dateFrom, _dateTo);
                            }
                          },
                        ),
                      )),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_m, vertical: Dimens.margin_s),
            decoration: AppTheme.inputDecorationShadow(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedTime,
                items: waktu.map(
                          (String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String value) {
                  setState(() {
                    _selectedTime = value;
                    _currentTimes = getFilterTime(value);
                    _dateFrom = "";
                    _dateTo = "";
                  });

                  if (_currentTimes != "7") {
                    _list.clear();
                    _rankDataController
                            .getSummary(context, setData, setLoadingState, _selectedteam, _selectedEcommerce, _currentTimes, _dateFrom, _dateTo);
                  }
                },
              ),
            ),
          ),
          showsDatePicker(
            int.parse(_currentTimes),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SyanaSummaryDetail(_list[index]))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: Dimens.listHeightSmall(context),
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              /* child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: index < 3
                                          ? AppTheme.text_darker
                                          : AppTheme.text_light,
                                      fontSize: 15,
                                    ),
                                  ),  */
                            ),
                          ),
                          Flexible(
                            flex: 20,
                            fit: FlexFit.tight,
                            child: Container(
                              child: Text(
                                _list[index].transactionNumber
                                /* rankBestProducts[index].name, */,
                                softWrap: true,
                                style: TextStyle(
                                  //color: AppTheme.
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            //fit: FlexFit.tight,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rp. ${GlobalFunctions.convertRupiah(_list[index].profitNetto)}"
                                    /* rankBestProducts[index].name, */,
                                    softWrap: true,
                                    style: TextStyle(
                                      //color: AppTheme.
                                      fontSize: 13,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "Rp. ${GlobalFunctions.convertRupiah(_list[index].costTotal)}"
                                    /* rankBestProducts[index].name, */,
                                    softWrap: true,
                                    style: TextStyle(
                                      //color: AppTheme.
                                      fontSize: 13,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
