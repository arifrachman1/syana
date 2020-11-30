import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/Controller/RankDataController.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/widgets/CustomImage.dart';

class SyanaIngrendientsRank extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<SyanaIngrendientsRank> {
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
      _rankIngrendients.clear();
      setLoadingState();
      await _rankDataController.getIngrendientsRank(context, setLoadingState,
          setData, _currentTime, _dateFrom, _dateTo, _currentTeams);
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
      _rankIngrendients.clear();
      setLoadingState();
      await _rankDataController.getIngrendientsRank(context, setLoadingState,
          setData, _currentTime, _dateFrom, _dateTo, _currentTeams);
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

  /* Components for Dropdown */
  List<String> _waktu = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Minggu lalu',
    'Bulan lalu',
    'Grand Total',
    'Tentukan sendiri'
  ];

  List<String> cakupan = ['Global', 'Lokal'];

  String _selectedWaktu;
  String _selectedCakupan;

  void onChangedTeam(value) {
    setState(() {
      this._selectedCakupan = value;
    });
  }

  /* API Components / Variables */
  String _selectedTime;
  String _currentTime;

  int _currentTeams = 0;

  RankDataController _rankDataController;
  InventoryController _inventoryController;

  List<ProductModel> _rankIngrendients = new List();
  List<DropdownMenuItem> _teams = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rankDataController = new RankDataController();
    _inventoryController = new InventoryController();

    _selectedTime = _waktu[0];
    _currentTime = 0.toString();

    initDataRank();
  }

  initDataRank() async {
    setLoadingState();
    await _rankDataController.getIngrendientsRank(context, setLoadingState,
        setData, _currentTime, _dateFrom, _dateTo, _currentTeams);
    await _inventoryController.getTeams(
        context, setLoadingState, setDropdownData, true);
    print("List: " + _rankIngrendients.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    if (this.mounted) {
      setState(() {
        _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
      });
    }
  }

  /* Dropdown Filter for Teams */
  void setDropdownData(data) {
    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          _teams = data;
          _currentTeams = _teams[0].value;
        });
      }
    }
  }

  //OnChanged Dropdown Filter Time
  void onChangedWaktu(value) async {
    setState(() {
      this._selectedTime = value;
      _currentTime = getFilterTime(_selectedTime);
      _dateFrom = "";
      _dateTo = "";
    });
    if (_currentTime != "7") {
      _rankIngrendients.clear();
      setLoadingState();
      await _rankDataController.getIngrendientsRank(context, setLoadingState,
          setData, _currentTime, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
    print(_selectedTime);
    print(_currentTime);
  }

  setData(data) {
    if (data is List<ProductModel> && data.isNotEmpty) {
      setState(() {
        _rankIngrendients = data;
      });
    }
  }

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
    // TODO: implement build
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _selectedTime,
                          items: _waktu.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            onChangedWaktu(value);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    showsDatePicker(
                      int.parse(_currentTime),
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
                    itemCount: _rankIngrendients.length,
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
                            /* Flexible(
                              flex: 17,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: CustomImage.getProductImage(rankBestProducts[index].image)
                              ),
                            ), */
                            Flexible(
                              flex: 53,
                              fit: FlexFit.tight,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _rankIngrendients[index].name ?? "-",
                                      softWrap: true,
                                      style: TextStyle(
                                          color: index < 3
                                              ? AppTheme.text_darker
                                              : AppTheme.text_light,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _rankIngrendients[index].sku ?? "-",
                                      softWrap: true,
                                      style: TextStyle(
                                        color: index < 3
                                            ? AppTheme.text_darker
                                            : AppTheme.text_light,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      _rankIngrendients[index].createAt ?? "-",
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
                                  _rankIngrendients[index].totalItem ?? "-",
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
