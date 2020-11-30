import 'dart:developer';

import 'package:flutter/material.dart';
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

  RankDataController _rankDataController;

  List<DropdownMenuItem> _listOfTeams = new List();
  List<DropdownMenuItem> _listOfEcommerce = new List();

  List<SummaryModel> _list = new List();
  int _selectedteam, _selectedEcommerce;

  void setLoadingState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String selectedToko;
  String selectedEcommerce;

  List _toko = [
    'Toko A (100|80|20)',
    'Toko B (100|80|20)',
    'Toko C (100|80|20)',
    'Toko D (100|80|20)',
  ];

  List _ecommerce = [
    'Shoope (10|8|2)',
    'Tokopedia (10|8|2)',
    'Bukalapak (10|8|2)',
    'JD.ID (10|8|2)',
  ];

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
          _rankDataController.getSummary(context, setData, setLoadingState, _selectedteam, _selectedEcommerce);
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: 20,
            alignment: Alignment.bottomLeft,
            child: Text(
              'Filter Toko',
              style: TextStyle(
                color: AppTheme.text_darker,
                fontSize: 12,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            //alignment: ,
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: 20,
            alignment: Alignment.bottomLeft,
            child: Text(
              'Filter E-Commerce',
              style: TextStyle(
                color: AppTheme.text_darker,
                fontSize: 12,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            //alignment: ,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
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
                              _rankDataController.getSummary(context, setData, setLoadingState, _selectedteam, item);
                            }
                          },
                        ),
                      )),
            ),
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
