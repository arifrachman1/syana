import 'package:flutter/material.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/FontHelper.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomImage.dart';

class SyanaStockIn extends StatefulWidget {
  @override
  StockInState createState() => StockInState();
}

class StockInState extends State<SyanaStockIn> {
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
    if (picked != null)
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
    if (picked != null && selectedDateTo.isAfter(selectedDateFrom)) {
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
      _inventoryController.getAddition(
          context,
          setLoadingState,
          setData,
          _isAsc ? "1" : "2",
          _currentTimeFilter,
          yearFrom + "-" + monthFrom + "-" + dayFrom,
          yearTo + "-" + monthTo + "-" + dayTo,
          _currentTeam);
    } else {
      setState(() {
        dayFrom = "DD";
        monthFrom = "MM";
        yearFrom = "YY";

        dayTo = "DD";
        monthTo = "MM";
        yearTo = "YY";
      });
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_WARNING,
          message: Strings.DIALOG_MESSAGE_INVALID_TIME_FILTER,
          context: context,
          popCount: 1);
    }
  }

  showsDatePicker(index) {
    if (index == 3) {
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
  // *
  // Komponen ListView
  // ==============================================

  List<List> barangMasuk = [
    ['(Better) Botanical Slimming Massage Oil', '9 SP', '-', 142],
    ['(Hotter) Botanical Slimming Massage Oil Carolina', '7 SP', '-', 148],
    ['(Kelapa) Evco Casa Di Sana', '0.7 SP', '-', 131],
    ['(Natuna) Tea Tree Essential', '1 SP', '-', 572],
    ['(Zaitun) Evco Casa Di Sana', '0.7 SP', '-', 152],
    ['(Zaitun) Evco Casa Di Sana', '9 SP', '-', 123],
    ['(Zaitun) Evco Casa Di Sana', '9 SP', '-', 456],
  ];

  getBarangMasuk(index, index2) {
    var selectedbarangMasuk = barangMasuk[index];
    return selectedbarangMasuk[index2];
  }

  // *
  // *
  // Komponen Dropdown button
  // ===========================================
  List<String> _timeFilterss = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Tentukan sendiri'
  ];
  List<String> _teamss = ['Global', 'Lokal'];

  int _currentTimeFilter;
  int _currentTeam;

  InventoryController _inventoryController;
  List<DropdownMenuItem> _teams = new List();
  List<DropdownMenuItem> _timeFilter = new List();
  List<ProductModel> additions = new List();
  bool _isLoading = false, _isAsc = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _inventoryController = new InventoryController();
    /*_currentTimeFilter = _timeFilter[0];*/
    _initTeams();
    /*_currentTeams = _teams[0];*/
  }

  _initTeams() async {
    await _inventoryController.getAddition(
        context, setLoadingState, setData, "1", 0, "", "", null);
    await _inventoryController.getTeams(
        context, setLoadingState, setTeamsData, true);

    /*generate time filter dropdown and its value*/
    _timeFilter = GlobalFunctions.generateDropdownMenuItem(
        childs: ["Hari ini", "Minggu ini", "Bulan ini", "Tentukan Sendiri"]);
    print(_timeFilter);
    _currentTimeFilter = _timeFilter[0].value;
  }

  void setLoadingState() {
    if (this.mounted) {
      setState(() {
        _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
      });
    }
  }

  void setData(data) {
    if (data is List<ProductModel>) {
      if (this.mounted) {
        setState(() {
          additions = data;
        });
      }
    }
  }

  void setTeamsData(data) {
    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          _teams = data;
          _currentTeam = data[0].value;
        });
      }
    }
  }

  void onChangedWaktu(value) {
    setState(() {
      this._currentTimeFilter = value;
    });
  }

  void onChangedCakupan(value) {
    setState(() {
      this._currentTeam = value;
    });
  }

  // ============================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CustomBottomNav.getBottomNav(context, 0),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.yellow,
          foregroundColor: Colors.black,
          tooltip: 'Add',
          child: Icon(Icons.filter_list),
          onPressed: () {
            setState(() {
              _isAsc = _isAsc ? false : true;
            });

            _inventoryController.getAddition(
                context,
                setLoadingState,
                setData,
                _isAsc ? "1" : "2",
                _currentTimeFilter,
                _currentTimeFilter == 3
                    ? (yearFrom == "YY" && monthFrom == "MM" && dayFrom == "DD"
                        ? ""
                        : (yearFrom + "-" + monthFrom + "-" + dayFrom))
                    : "",
                _currentTimeFilter == 3
                    ? (yearTo == "YY" && monthTo == "MM" && dayTo == "DD"
                        ? ""
                        : (yearTo + "-" + monthTo + "-" + dayTo))
                    : "",
                _currentTeam);
          },
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  _inventoryController.getAddition(
                      context,
                      setLoadingState,
                      setData,
                      _isAsc ? "1" : "2",
                      _currentTimeFilter,
                      _currentTimeFilter == 3
                          ? (yearFrom == "YY" &&
                                  monthFrom == "MM" &&
                                  dayFrom == "DD"
                              ? ""
                              : (yearFrom + "-" + monthFrom + "-" + dayFrom))
                          : "",
                      _currentTimeFilter == 3
                          ? (yearTo == "YY" && monthTo == "MM" && dayTo == "DD"
                              ? ""
                              : (yearTo + "-" + monthTo + "-" + dayTo))
                          : "",
                      _currentTeam);
                },
                child: Column(
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
                                      value: _currentTimeFilter,
                                      items: _timeFilter,
                                      onChanged: (value) {
                                        setState(() {
                                          _currentTimeFilter = value;
                                        });
                                        _inventoryController.getAddition(
                                            context,
                                            setLoadingState,
                                            setData,
                                            _isAsc ? "1" : "2",
                                            _currentTimeFilter,
                                            _currentTimeFilter == 3
                                                ? (yearFrom == "YY" &&
                                                        monthFrom == "MM" &&
                                                        dayFrom == "DD"
                                                    ? ""
                                                    : (yearFrom +
                                                        "-" +
                                                        monthFrom +
                                                        "-" +
                                                        dayFrom))
                                                : "",
                                            _currentTimeFilter == 3
                                                ? (yearTo == "YY" &&
                                                        monthTo == "MM" &&
                                                        dayTo == "DD"
                                                    ? ""
                                                    : (yearTo +
                                                        "-" +
                                                        monthTo +
                                                        "-" +
                                                        dayTo))
                                                : "",
                                            _currentTeam);
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
                                      value: _currentTeam,
                                      items: _teams,
                                      onChanged: (value) {
                                        setState(() {
                                          _currentTeam = value;
                                        });
                                        _inventoryController.getAddition(
                                            context,
                                            setLoadingState,
                                            setData,
                                            "1",
                                            _currentTimeFilter,
                                            yearFrom +
                                                "-" +
                                                monthFrom +
                                                "-" +
                                                dayFrom,
                                            yearTo +
                                                "-" +
                                                monthTo +
                                                "-" +
                                                dayTo,
                                            _currentTeam);
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
                          showsDatePicker(_currentTimeFilter),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: additions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: AppTheme.listBackground(),
                              height: Dimens.listHeightSmall(context),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 17,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CustomImage.getProductImage(additions[index].image)
                                    ),
                                  ),
                                  Flexible(
                                    flex: 63,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            additions[index].name,
                                            softWrap: true,
	                                          style: FontHelper.textListTitle,
                                          ),
                                          Text(
                                            additions[index].point +
                                                ' | ' +
                                                (additions[index].sku != null
                                                    ? additions[index].sku != ""
                                                        ? additions[index].sku
                                                        : "-"
                                                    : "-"),
                                            softWrap: true,
	                                          style: FontHelper.textListSubtitle,
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
                                        additions[index].stock,
                                        softWrap: true,
	                                      style: FontHelper.textListSubtitle,
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
                ),
              ));
  }
}
