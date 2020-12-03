import 'dart:developer';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ChartDataModel.dart';
import 'package:syana/models/TraceModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';

String selectedPromo;
int selectedGrafik = 0;

class GrafikGlobal extends StatefulWidget {
  @override
  GrafikGlobalState createState() => GrafikGlobalState();
}

class GrafikGlobalState extends State<GrafikGlobal> {
  DateFormat formatDate = DateFormat("yyyy-MM-dd HH:mm");
  DateFormat formatDateDayOnly = DateFormat("dd");
  DateTime timeStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime timeEnd = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  String _currentTimeStart;
  String _currentTimeEnd;

  String _currentSelectedDate = "";
  String filterTypeName = "Terjual";

  int _valueData = 0;

  int totalData = 0;

  //Build Chart
  List<charts.Series<Sales, int>> _seriesLineData;
  List<charts.Series<TimeSeriesSales, DateTime>> _timeSeriesLineData;

  Future<bool> _generateData(List value) async {
    try {
      List<Sales> chartData = new List();
      List<TimeSeriesSales> chartDataTime = new List();
      List<DateTime> range = calculateDaysInterval(timeStart, timeEnd);
      for (int i = 0; i < value.length; i++) {
        DateTime date;
        try {
          date = DateTime.tryParse(chartGlobal[i].chartDate.toString());
        } catch (e) {
          log(e.toString(), name: "error");
        }
        setState(() {
          if (_currentFilterType == "3") {
            chartDataTime.add(new TimeSeriesSales(date, chartGlobal[i].value));
            totalData += chartGlobal[i].value;
          } else {
            chartDataTime.add(new TimeSeriesSales(date, int.parse(chartGlobal[i].chartValue)));
            totalData += int.parse(chartGlobal[i].chartValue);
          }
        });
      }
      await _timeSeriesLineData.clear();
      await _timeSeriesLineData.add(charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: chartDataTime,
      ));
      return true;
    } catch (e) {
//      CustomDialog.getDialog("Error", e.toString(), context);
    }
    return false;
  }

  _onSelectionChanged(charts.SelectionModel model) async {
    listDataTrace.clear();
    final selectedDatum = model.selectedDatum;

    DateTime selectedDate;
    int values;
    String convertedDate = "";

    if (selectedDatum.isNotEmpty) {
      values = selectedDatum.first.datum.sales;
      selectedDate = selectedDatum.first.datum.time;
    }
    convertedDate = formatDateDayOnly.format(selectedDate);
    // Request a build.
    setState(() {
      _currentSelectedDate = convertedDate;
      _valueData = values;
    });
    await _saleController.getAllTrace(context, setData, _currentSelectedDate);
    print(listDataTrace.length);
  }

  // API Implementation

  SaleController _saleController;
  bool _isLoading = false;
  List<ChartDataModel> chartGlobal = new List();
  List<TraceModel> listDataTrace = new List();
  List<DateTime> listDateChart = new List();
  String _currentFilterType = "4";
  ChartDataModel dateMaxMin;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _saleController = new SaleController();
    _currentTimeStart = formatDate.format(DateTime.now());
    _currentTimeEnd = "";
    _seriesLineData = List<charts.Series<Sales, int>>();
    _timeSeriesLineData = List<charts.Series<TimeSeriesSales, DateTime>>();
    initDataChart();
  }

  initDataChart() async {
    setLoadingState();
    await _saleController.getChartData(context, setLoadingState, setData, "1", _currentFilterType, _currentTimeStart, _currentTimeEnd, "", "");
    print("list length : " + chartGlobal.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    if (this.mounted) {
      setState(() {
        _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
      });
    }
  }

  setData(data) {
    if (data is List<ChartDataModel> && data.isNotEmpty) {
      setState(() {
        chartGlobal = data;
        /*chartGlobal.forEach((element) {
          var _tempDateTime = DateTime.parse(element.chartDate.toString());
          listDateChart.add(_tempDateTime);
        });*/
        _generateData(chartGlobal);
      });
    } else if (data is List<TraceModel> && data.isNotEmpty) {
      setState(() {
        listDataTrace = data;
      });
    } else if (data is ChartDataModel && data != null) {
      setState(() {
        dateMaxMin = data;
      });
    }
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
            ? Center(
      child: CircularProgressIndicator(),
    )
            : Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _currentSelectedDate == ""
                          ? Container()
                          : Container(
                    child: Text(
                      _currentSelectedDate + " : " + _valueData.toString() + " Pcs",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
//                        Container(
//                          height: MediaQuery.of(context).size.height * 0.02,
//                        ),
                  Container(
                    height: Dimens.grafikHeight(context),
                    child: buildChart(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          totalData.toString(),
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Produk ' + filterTypeName,
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: AppTheme.listBackground(),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Data dari ',
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 14,
                          ),
                          softWrap: true,
                        ),
                        Text(
                          GlobalFunctions.formatStringDate(
                                  targetDateTime: _currentTimeStart,
                                  sourceFormat: GlobalFunctions.FORMAT_YYYY_MM_DD,
                                  intendedFormat: GlobalFunctions.FORMAT_DD_MM_YYYY),
                          style: TextStyle(
                            color: AppTheme.orange_light,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                        _currentTimeEnd != "" ?
                        Text(
                          ' hingga ',
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 14,
                          ),
                          softWrap: true,
                        ) : Container(),
                        Text(
                          _currentTimeEnd != ""
                                  ? GlobalFunctions.formatStringDate(
                                  targetDateTime: _currentTimeEnd,
                                  sourceFormat: GlobalFunctions.FORMAT_YYYY_MM_DD,
                                  intendedFormat: GlobalFunctions.FORMAT_DD_MM_YYYY)
                                  : "",
                          style: TextStyle(
                            color: AppTheme.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
//                        Container(
//                          height: MediaQuery.of(context).size.height * 0.3,
//                        ),
                  listDataTrace.length < 0
                          ? Container()
                          : Container(
                          height: 100,
                          child: ListView.builder(
//                              shrinkWrap: true,
                                  itemCount: listDataTrace.length,
                                  itemBuilder: (context, position) {
                                    return buildListDetailChart(position);
                                  }))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, right: 10),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: AppTheme.yellow,
              foregroundColor: Colors.black,
              tooltip: 'Add',
              child: Icon(Icons.filter_list),
              onPressed: () {
                menuFilter();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Grafik Global',
            style: TextStyle(
              color: AppTheme.text_light,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 37,
          ),
          chartGlobal.length < 1
                  ? Center(
            child: Text("Belum ada data"),
          )
                  : Expanded(
                  child: charts.TimeSeriesChart(
                    _timeSeriesLineData,
                    domainAxis: charts.DateTimeAxisSpec(
                            tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                              year: charts.TimeFormatterSpec(
                                      format: "yyyy-MM",
                                      transitionFormat: "yyyy-MM"
                              ),
                              month: charts.TimeFormatterSpec(
                                      format: 'MM-dd',
                                      transitionFormat: "MM-dd"
                              ),
                              day: charts.TimeFormatterSpec(
                                      format: 'MM-dd',
                                      transitionFormat: 'MM-dd'
                              ),
                              hour: charts.TimeFormatterSpec(
                                      format: 'HH:mm',
                                      transitionFormat: "HH:mm"
                              ),

                            )
                    ),
                    animate: false,
                    behaviors: [new charts.PanAndZoomBehavior()],
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                    selectionModels: [
                      new charts.SelectionModelConfig(
                        changedListener: _onSelectionChanged,
                      )
                    ],
                  )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildListDetailChart(int index) {
    return ListTile(
      title: Text(listDataTrace[index].trace),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          listDataTrace[index].productName == "no data" ? Text(listDataTrace[index].teamName) : Text(listDataTrace[index].productName),
          Text(listDataTrace[index].employeeName)
        ],
      ),
    );
  }

  menuFilter() {
    showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              int filterType = 4;
              DateTime _tempTimeStart;
              DateTime _tempTimeEnd;
              String timeStartTemp = "PILIH TANGGAL";
              String timeEndTemp = "PILIH TANGGAL";
              return AlertDialog(
                      shape: AppTheme.popupRoundedBackground(),
                      actions: <Widget>[
                        FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("BATAL", style: TextStyle(color: AppTheme.teal_light))),
                        FlatButton(
                          color: Colors.white,
                          child: Text(
                            "TERAPKAN",
                            style: TextStyle(color: AppTheme.teal_light),
                          ),
                          onPressed: () async {
                            setState(() {
                              if (_tempTimeStart != null) {
                                _currentFilterType = filterType.toString();
                                _currentTimeStart = timeStartTemp;
                                _currentTimeEnd = timeEndTemp != "PILIH TANGGAL" ? timeEndTemp : "";
                              } else {
                                _currentFilterType = filterType.toString();
                              }
                              totalData = 0;
                            });
                            Navigator.of(context).pop();
                            chartGlobal.clear();
                            listDataTrace.clear();
                            setLoadingState();
                            await _saleController.getChartData(
                                    context, setLoadingState, setData, "1", _currentFilterType, _currentTimeStart, _currentTimeEnd, "", "");
                            print("list length : " + chartGlobal.length.toString());
                            setLoadingState();
                          },
                        ),
                      ],
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Filter Waktu",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day - 7);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "1W",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      minWidth: 50,
                                    ),
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month - 1, DateTime
                                                    .now()
                                                    .day);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "1M",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      minWidth: 50,
                                    ),
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month - 6, DateTime
                                                    .now()
                                                    .day);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "6M",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      minWidth: 50,
                                    ),
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year, 1, 1);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "YTD",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      minWidth: 50,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year - 1, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "1Y",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      minWidth: 50,
                                    ),
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          setState(() {
                                            _tempTimeStart = DateTime(DateTime
                                                    .now()
                                                    .year - 5, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            _tempTimeEnd = DateTime(DateTime
                                                    .now()
                                                    .year, DateTime
                                                    .now()
                                                    .month, DateTime
                                                    .now()
                                                    .day);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        child: Text(
                                          "5Y",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      ),
                                      minWidth: 50,
                                    ),
                                    ButtonTheme(
                                      child: RaisedButton(
                                        color: Colors.blueGrey[900],
                                        onPressed: () async {
                                          await _saleController.checkMaxFilter(context, setData);
                                          print(dateMaxMin.dateMin);
                                          setState(() {
                                            _tempTimeStart = DateTime.parse(dateMaxMin.dateMin);
                                            _tempTimeEnd = DateTime.parse(dateMaxMin.dateMax);
                                            timeStartTemp = formatDate.format(_tempTimeStart);
                                            timeEndTemp = formatDate.format(_tempTimeEnd);
                                          });
                                        },
                                        child: Text(
                                          "MAX",
                                          style: TextStyle(fontSize: 8, color: AppTheme.text_light, fontWeight: FontWeight.bold),
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      ),
                                      minWidth: 50,
                                    ),
                                    Container(
                                      width: 50,
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "From",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: AppTheme.dateDecorationShadow(),
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.date_range,
                                                    color: AppTheme.white,
                                                  ),
                                                  Text(
                                                    timeStartTemp != "PILIH TANGGAL"
                                                            ? GlobalFunctions.formatStringDate(
                                                            targetDateTime: timeStartTemp,
                                                            sourceFormat: GlobalFunctions.FORMAT_YYYY_MM_DD,
                                                            intendedFormat: GlobalFunctions.FORMAT_DD_MM_YYYY)
                                                            : timeStartTemp,
                                                    style: TextStyle(color: AppTheme.white, fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              final DateTime pickedStart = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );

                                              setState(() {
                                                _tempTimeStart = pickedStart;
                                                timeStartTemp = formatDate.format(_tempTimeStart);
                                              });
                                              log(timeStartTemp);
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
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 5),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "To",
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    // margin: EdgeInsets.only(top: 10),
                                                    // padding: EdgeInsets.only(left: 10),
                                                    decoration: AppTheme.dateDecorationShadow(),
                                                    height: 35,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.date_range,
                                                          color: AppTheme.white,
                                                        ),
                                                        Text(
                                                          timeEndTemp != "PILIH TANGGAL"
                                                                  ? GlobalFunctions.formatStringDate(
                                                                  targetDateTime: timeEndTemp,
                                                                  sourceFormat: GlobalFunctions.FORMAT_YYYY_MM_DD,
                                                                  intendedFormat: GlobalFunctions.FORMAT_DD_MM_YYYY)
                                                                  : timeEndTemp,
                                                          style: TextStyle(color: AppTheme.white, fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final DateTime pickedEnd = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    print(pickedEnd);
                                                    setState(() {
                                                      _tempTimeEnd = pickedEnd;
                                                      timeEndTemp = formatDate.format(_tempTimeEnd);
                                                    });
                                                    print("Time End " + timeEndTemp);
                                                  },
                                                ),
                                              ],
                                            )),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Filter Data",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    new Radio(
                                      value: 1,
                                      groupValue: filterType,
                                      onChanged: (int value) {
                                        setState(() {
                                          filterType = value;
                                          filterTypeName = "Penjualan";
                                        });
                                      },
                                    ),
                                    Text("Penjualan"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    new Radio(
                                      value: 2,
                                      groupValue: filterType,
                                      onChanged: (int value) {
                                        setState(() {
                                          filterType = value;
                                          filterTypeName = "Free";
                                        });
                                      },
                                    ),
                                    Text("Free"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    new Radio(
                                      value: 3,
                                      groupValue: filterType,
                                      onChanged: (int value) {
                                        setState(() {
                                          filterType = value;
                                          filterTypeName = "Penjualan dan Free";
                                        });
                                      },
                                    ),
                                    Text("Penjualan dan Free"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    new Radio(
                                      value: 4,
                                      groupValue: filterType,
                                      onChanged: (int value) {
                                        setState(() {
                                          filterType = value;
                                          filterTypeName = "Paket";
                                        });
                                      },
                                    ),
                                    Text("Paket"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    new Radio(
                                      value: 5,
                                      groupValue: filterType,
                                      onChanged: (int value) {
                                        setState(() {
                                          filterType = value;
                                          filterTypeName = "Retur";
                                        });
                                      },
                                    ),
                                    Text("Retur"),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ));
            });
  }
}

class Sales {
  final int salesval;
  final int dateval;

  Sales(this.dateval, this.salesval);
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
