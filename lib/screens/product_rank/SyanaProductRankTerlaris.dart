import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

class SyanaProductRankTerlaris extends StatefulWidget {
  @override
  RankState createState() => RankState();
}

class RankState extends State<SyanaProductRankTerlaris> {
  // *
  // *
  // *
  // Komponen DatePicker
  // ==============================================
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  String dayFrom = "DD";
  String monthFrom = "MM";
  String yearFrom = "YY";

  String dayTo = "DD";
  String monthTo = "MM";
  String yearTo = "YY";

  Future<Null> selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
  }

  Future<Null> selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
  }

  showsDatePicker(index) {
    if (index == 7) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
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
              width: MediaQuery.of(context).size.width * 0.03,
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

  // *
  // *
  // Komponen Dropdown button
  // ===========================================
  List<String> waktu = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Kemarin',
    'Minggu lalu',
    'Bulan lalu',
    'Grand Total',
    'Tentukan sendiri'
  ];
  List<String> cakupan = ['Global', 'Lokal'];

  String selectedTime;
  String selectedCakupan;
  String currentTime;

  void onChangedWaktu(value) {
    setState(() {
      this.selectedTime = value;
      currentTime = waktu.indexOf(value).toString();
    });
    initDataRank();
  }

  void onChangedCakupan(value) {
    setState(() {
      this.selectedCakupan = value;
    });
  }

  // ===== API Component/Variables

  SaleController _saleController;
  bool _isLoading = false;

  List<ProductModel> rankProducts = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saleController = new SaleController();
    selectedTime = waktu[0];
    selectedCakupan = cakupan[0];
    currentTime = 0.toString();
    initDataRank();
    print("initstate");
    print("date from "+ selectedDateFrom.toString());
  }

  initDataRank() async {
    setLoadingState();
    await _saleController.getRankProducts(
        context, setLoadingState, setData, "2", currentTime, "", "", "20");
    //getHistoryProducts(context, setLoadingState, setData);
    print("list length : " + rankProducts.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is List<ProductModel> && data.isNotEmpty) {
      setState(() {
        rankProducts = data;
      });
    }
  }

  // ============================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedTime,
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
                            onChangedWaktu(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    child: Container(
                      // width: 150,
                      padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedCakupan,
                          items: cakupan.map(
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
                            onChangedCakupan(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              showsDatePicker(
                waktu.indexOf(selectedTime),
              ),
            ],
          ),
        ),
        Expanded(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: rankProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: AppTheme.listBackground(),
                        height: Dimens.listHeightSmall(context),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 17,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.image,
                                  size: 60,
                                  color: AppTheme.teal_light,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 53,
                              fit: FlexFit.tight,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      rankProducts[index].name,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      rankProducts[index].sku,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 20,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  rankProducts[index].rankValue,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                    fontSize: 14,
                                  ),
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
      ],
    );
  }
}
