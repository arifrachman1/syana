import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

class SyanaProductRankTopLokasi extends StatefulWidget {
  @override
  SyanaProductRankTopLokasiState createState() =>
      SyanaProductRankTopLokasiState();
}

class SyanaProductRankTopLokasiState extends State<SyanaProductRankTopLokasi> {
  // *
  // *
  // *
  // Komponen DatePicker
  // ==============================================
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
    _dateFrom = formatDate.format(selectedDateFrom);
    if (_dateFrom != "" && _dateTo != "") {
      rankTopLocation.clear();
      setLoadingState();
      await _saleController.getTopLocation(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams, _currentType);
      setLoadingState();
    }
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
    _dateTo = formatDate.format(selectedDateTo);
    if (_dateFrom != "" && _dateTo != "") {
      rankTopLocation.clear();
      setLoadingState();
      await _saleController.getTopLocation(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams, _currentType);
      setLoadingState();
    }
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
  List<String> tipe = ['Kota', 'Provinsi'];

  String selectedWaktu;
  String selectedCakupan;

  void onChangedCakupan(value) {
    setState(() {
      this.selectedCakupan = value;
    });
  }

  // ===== API Component/Variables
  String selectedTime;
  String _currentTimes;

  String selectedType;
  String _currentType;

  int _currentTeams = 0;

  SaleController _saleController;
  InventoryController _inventoryController;

  bool _isLoading = false;

  List<ProductModel> rankTopLocation = new List();
  List<DropdownMenuItem> teams = new List();

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
    _inventoryController = new InventoryController();

    selectedTime = waktu[0];
    _currentTimes = 0.toString();

    selectedType = tipe[0];
    _currentType = 0.toString();

    initDataRank();
  }

  initDataRank() async {
    setLoadingState();
    await _saleController.getTopLocation(context, setLoadingState, setData,
        _currentTimes, "", "", _currentTeams, _currentType);
    await _inventoryController.getTeams(
        context, setLoadingState, setDropdownData, true);
    print("list length : " + rankTopLocation.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  //Dropdown Filter Teams
  void setDropdownData(data) {
    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
      setState(() {
        teams = data;
        _currentTeams = teams[0].value;
      });
    }
  }

  //OnChanged Dropdown Filter Time
  void onChangedWaktu(value) async {
    setState(() {
      this.selectedTime = value;
      _currentTimes = waktu.indexOf(value).toString();
      _dateFrom = "";
      _dateTo = "";
    });
    if (_currentTimes != "7") {
      rankTopLocation.clear();
      setLoadingState();
      await _saleController.getTopLocation(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams, _currentType);
      setLoadingState();
    }
  }

  //OnChanged Dropdown Filter Time
  void onChangedTipe(value) async {
    setState(() {
      this.selectedType = value;
      _currentType = tipe.indexOf(value).toString();
    });
    rankTopLocation.clear();
    setLoadingState();
    await _saleController.getTopLocation(context, setLoadingState, setData,
        _currentTimes, _dateFrom, _dateTo, _currentTeams, _currentType);
    setLoadingState();
  }

  setData(data) {
    if (data is List<ProductModel> && data.isNotEmpty) {
      setState(() {
        rankTopLocation = data;
      });
    }
  }

  // ============================================

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
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
                                  items: teams,
                                  value: _currentTeams,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentTeams = value;
                                    });
                                    setLoadingState();
                                    rankTopLocation.clear();
                                    await _saleController.getTopLocation(
                                        context,
                                        setLoadingState,
                                        setData,
                                        _currentTimes,
                                        _dateFrom,
                                        _dateTo,
                                        _currentTeams,
                                        _currentType);
                                    setLoadingState();
                                  },
                                ),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedType,
                          items: tipe.map(
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
                            onChangedTipe(value);
                          },
                        ),
                      ),
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
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: rankTopLocation.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color:
                              index < 3 ? AppTheme.teal_light : AppTheme.teal,
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                                    color: index < 3
                                        ? AppTheme.text_darker
                                        : AppTheme.text_light,
                                    fontSize: 15,
                                  ),
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
                                      rankTopLocation[index].name,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: index < 3
                                            ? AppTheme.text_darker
                                            : AppTheme.text_light,
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
                                  rankTopLocation[index].rankValue,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: index < 3
                                        ? AppTheme.text_darker
                                        : AppTheme.text_light,
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
