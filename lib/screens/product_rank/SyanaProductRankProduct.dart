import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ChartDataModel.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/TraceModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

String selectedProduk;
int selectedGrafik = 0;

class GrafikProduk extends StatefulWidget {
  @override
  GrafikProdukState createState() => GrafikProdukState();
}

class GrafikProdukState extends State<GrafikProduk> {
  String _devTitle = "Grafik";

  DateFormat formatDate = DateFormat("yyyy-MM-dd");
  DateFormat formatDateDayOnly = DateFormat("dd");
  DateTime timeStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime timeEnd = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  String _currentTimeStart;
  String _currentTimeEnd;

  String _currentSelectedDate = "";
  String filterTypeName = "Terjual";
  int _valueData = 0;

  String _current1st = "", _current2nd = "";

  int totalData = 0;
  int totalDataCompared = 0;

  //Build Chart
  List<charts.Series<TimeSeriesSales, DateTime>> _timeSeriesLineData;

  Future<bool> _generateData(List value) async {
    try {
      List<TimeSeriesSales> chartDataTime = new List();
      List<DateTime> range = calculateDaysInterval(timeStart, timeEnd);
      print("Range : ");
      print(listDateChart);
      for (int i = 0; i < value.length; i++) {
        setState(() {
          DateTime date = DateTime.parse(chartProducts[i].chartDate);
          if (_currentFilterType == "3") {
            chartDataTime
                .add(new TimeSeriesSales(date, chartProducts[i].value));
            totalData += chartProducts[i].value;
          } else {
            chartDataTime.add(new TimeSeriesSales(
                date, int.parse(chartProducts[i].chartValue)));
            totalData += int.parse(chartProducts[i].chartValue);
          }
        });
      }
      // await _timeSeriesLineData.clear();
      await _timeSeriesLineData.add(charts.Series<TimeSeriesSales, DateTime>(
        id: _current1st,
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: chartDataTime,
      ));
      return true;
    } catch (e) {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    return false;
  }

  Future<bool> _generateDataCompare(List value) async {
    try {
      List<TimeSeriesSales> chartDataTimeCompare = new List();
      print(listDateChart);
      for (int i = 0; i < value.length; i++) {
        setState(() {
          DateTime dateCompare =
              DateTime.parse(chartComparedProducts[i].chartDate);
          if (_currentFilterType == "3") {
            chartDataTimeCompare.add(new TimeSeriesSales(
                dateCompare, chartComparedProducts[i].value));
            totalDataCompared += chartComparedProducts[i].value;
          } else {
            chartDataTimeCompare.add(new TimeSeriesSales(
                dateCompare, int.parse(chartComparedProducts[i].chartValue)));
            totalDataCompared += int.parse(chartComparedProducts[i].chartValue);
          }
        });
      }
      // await _timeSeriesLineData.clear();
      await _timeSeriesLineData.add(charts.Series<TimeSeriesSales, DateTime>(
        id: _current2nd,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: chartDataTimeCompare,
      ));
      return true;
    } catch (e) {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    return false;
  }

  _onSelectionChanged(charts.SelectionModel model) async {
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
    if (_currentComparedProducts == null) {
      await _saleController.getAllTrace(context, setData, _currentSelectedDate);
      print(listDataTrace.length);
    }
  }

  // API Implementation

  SaleController _saleController;
  bool _isLoading = false;
  List<ChartDataModel> chartProducts = new List();
  List<ChartDataModel> chartComparedProducts = new List();
  List<TraceModel> listDataTrace = new List();
  List<DateTime> listDateChart = new List();
  List<ProductModel> products = new List();
  ChartDataModel dateMaxMin;

  ProductModel _selectedProducts;
  ProductModel _selectedComparedProducts;

  String _currentFilterType = "1";
  String _currentProducts;
  String _currentComparedProducts;

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
    _currentTimeStart = formatDate.format(timeStart);
    _currentTimeEnd = formatDate.format(timeEnd);
    _timeSeriesLineData = List<charts.Series<TimeSeriesSales, DateTime>>();
    initData();
  }

  initData() async {
    setLoadingState();
    await _saleController.getProducts(context, setLoadingState, setData);
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is List<ChartDataModel> && data.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          chartProducts = data;
          chartProducts.forEach((element) {
            String tempConvDate =
                formatDate.format(DateTime.parse(element.chartDate));
            listDateChart.add(DateTime.parse(tempConvDate));
          });
          _generateData(chartProducts);
        });
      }
    } else if (data is List<TraceModel> && data.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          listDataTrace = data;
        });
      }
    } else if (data is List<ProductModel> && data.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          products = data;
        });
      }
    } else if (data is ChartDataModel && data != null) {
      if (this.mounted) {
        setState(() {
          dateMaxMin = data;
        });
      }
    }
  }

  setDataCompared(data2) {
    if (data2 is List<ChartDataModel> && data2.isNotEmpty) {
      setState(() {
        chartComparedProducts = data2;
        GlobalFunctions.log(
            message: chartComparedProducts.toString(), name: _devTitle);
        _generateDataCompare(chartComparedProducts);
      });
    }
  }

//  //Dropdown Filter Teams
//  void setDropdownData(data) {
//    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
//      setState(() {
//        products = data;
//        _currentProducts = products[0].value;
//      });
//    }
//  }

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
                            _currentSelectedDate +
                                " : " +
                                _valueData.toString() +
                                " Paket",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 13, right: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pilih Produk',
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 14,
                            ),
                            softWrap: true,
                          ),
                        ),
                        SearchableDropdown.single(
                          items: products.map((ProductModel product) {
                            return DropdownMenuItem<ProductModel>(
                              value: product,
                              child: Text(
                                product.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          value: _selectedProducts,
                          hint: "Pilih Produk",
                          searchHint: "Cari Produk",
                          onChanged: (ProductModel value) async {
                            if (value != null) {
                              print(value.id);
                              setState(() {
                                _selectedProducts = value;
                                _currentProducts = value.id.toString();
                                _current1st = value.name;
                                print(_selectedProducts);
                              });
                              chartProducts.clear();
                              listDataTrace.clear();
                              setLoadingState();
                              await _saleController.getChartData(
                                  context,
                                  setLoadingState,
                                  setData,
                                  "3",
                                  _currentFilterType,
                                  _currentTimeStart,
                                  _currentTimeEnd,
                                  "",
                                  _currentProducts);
                              print("list length : " +
                                  chartProducts.length.toString());
                              setLoadingState();
                            }
                          },
                          isExpanded: true,
                        ),
                        SearchableDropdown.single(
                          items: products.map((ProductModel product) {
                            return DropdownMenuItem<ProductModel>(
                              value: product,
                              child: Text(
                                product.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          value: _selectedComparedProducts,
                          hint: "Pilih Produk 2",
                          searchHint: "Cari Produk",
                          onChanged: (ProductModel value) async {
                            if (value != null && _currentProducts != null) {
                              print(value.id);
                              setState(() {
                                _selectedComparedProducts = value;
                                _currentComparedProducts = value.id.toString();
                                _current2nd = value.name;
                                print(_selectedComparedProducts);
                              });
                              chartComparedProducts.clear();
                              listDataTrace.clear();
                              setLoadingState();
                              await _saleController.getChartData(
                                  context,
                                  setLoadingState,
                                  setDataCompared,
                                  "3",
                                  _currentFilterType,
                                  _currentTimeStart,
                                  _currentTimeEnd,
                                  "",
                                  _currentComparedProducts);
                              print("list length : " +
                                  chartProducts.length.toString());
                              setLoadingState();
                            } else {
                              CustomDialog.getDialog(
                                  title: Strings.DIALOG_TITLE_WARNING,
                                  message:
                                      Strings.DIALOG_MESSAGE_INVALID_FILTER,
                                  context: context,
                                  popCount: 1);
                              setState(() {
                                _currentComparedProducts = null;
                              });
                            }
                          },
                          isExpanded: true,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          height: Dimens.grafikHeight(context),
                          child: buildChart(),
                        ),
                        _selectedComparedProducts == null
                            ? Container(
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
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          totalData.toString(),
                                          style: TextStyle(
                                            color: Colors.yellow,
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
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          totalDataCompared.toString(),
                                          style: TextStyle(
                                            color: Colors.blue,
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
                                  ],
                                ),
                              ),


                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: AppTheme.listBackground(),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
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
                                _currentTimeStart,
                                style: TextStyle(
                                  color: AppTheme.orange_light,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                ' hingga ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 14,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                _currentTimeEnd,
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

                        listDataTrace.length < 0 &&
                                _currentComparedProducts != null
                            ? Container()
                            : Container(
                                height: 100,
                                child: ListView.builder(
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

  Widget buildListDetailChart(int index) {
    return ListTile(
      title: Text(listDataTrace[index].trace),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          listDataTrace[index].productName == "no data"
              ? Text(listDataTrace[index].teamName)
              : Text(listDataTrace[index].productName),
          Text(listDataTrace[index].employeeName)
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
            'Grafik Produk',
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
          chartProducts.length < 1
              ? Center(
                  child: Text("Belum ada data"),
                )
              : Expanded(
                  child: charts.TimeSeriesChart(
                  _timeSeriesLineData,
                  animate: false,
                  behaviors: [
                    new charts.PanAndZoomBehavior(),
                    charts.SeriesLegend()
                  ],
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

  menuFilter() {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          int filterType = 1;
          DateTime _tempTimeStart;
          DateTime _tempTimeEnd;
          String timeStartTemp = "PILIH TANGGAL";
          String timeEndTemp = "PILIH TANGGAL";
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("BATAL",
                        style: TextStyle(color: AppTheme.teal_light))),
                FlatButton(
                  color: Colors.white,
                  child: Text(
                    "TERAPKAN",
                    style: TextStyle(color: AppTheme.teal_light),
                  ),
                  onPressed: () async {
                    setState(() {
                      if (_tempTimeStart != null && _tempTimeEnd != null) {
                        _currentFilterType = filterType.toString();
                        _currentTimeStart = timeStartTemp;
                        _currentTimeEnd = timeEndTemp;
                      } else {
                        _currentFilterType = filterType.toString();
                      }
                      totalData = 0;
                    });
                    Navigator.of(context).pop();
                    chartProducts.clear();
                    chartComparedProducts.clear();
                    listDataTrace.clear();
                    setLoadingState();
                    await _saleController.getChartData(
                        context,
                        setLoadingState,
                        setData,
                        "3",
                        _currentFilterType,
                        _currentTimeStart,
                        _currentTimeEnd,
                        "",
                        _currentProducts);
                    await _saleController.getChartData(
                        context,
                        setLoadingState,
                        setDataCompared,
                        "3",
                        _currentFilterType,
                        _currentTimeStart,
                        _currentTimeEnd,
                        "",
                        _currentComparedProducts);
                    print("list length : " + chartProducts.length.toString());
                    setLoadingState();
                  },
                ),
              ],
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
//                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
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
                                    _tempTimeStart = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day - 7);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "1W",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              minWidth: 50,
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                color: Colors.blueGrey[900],
                                onPressed: () {
                                  setState(() {
                                    _tempTimeStart = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month - 1,
                                        DateTime.now().day);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "1M",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              minWidth: 50,
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                color: Colors.blueGrey[900],
                                onPressed: () {
                                  setState(() {
                                    _tempTimeStart = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month - 6,
                                        DateTime.now().day);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "6M",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              minWidth: 50,
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                color: Colors.blueGrey[900],
                                onPressed: () {
                                  setState(() {
                                    _tempTimeStart =
                                        DateTime(DateTime.now().year, 1, 1);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "YTD",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
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
                                    _tempTimeStart = DateTime(
                                        DateTime.now().year - 1,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "1Y",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              minWidth: 50,
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                color: Colors.blueGrey[900],
                                onPressed: () {
                                  setState(() {
                                    _tempTimeStart = DateTime(
                                        DateTime.now().year - 5,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    _tempTimeEnd = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                child: Text(
                                  "5Y",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              minWidth: 50,
                            ),
                            ButtonTheme(
                              child: RaisedButton(
                                color: Colors.blueGrey[900],
                                onPressed: () async {
                                  await _saleController.checkMaxFilter(
                                      context, setData);
                                  print(dateMaxMin.dateMin);
                                  setState(() {
                                    _tempTimeStart =
                                        DateTime.parse(dateMaxMin.dateMin);
                                    _tempTimeEnd =
                                        DateTime.parse(dateMaxMin.dateMax);
                                    timeStartTemp =
                                        formatDate.format(_tempTimeStart);
                                    timeEndTemp =
                                        formatDate.format(_tempTimeEnd);
                                  });
                                },
                                child: Text(
                                  "MAX",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: AppTheme.text_light,
                                      fontWeight: FontWeight.bold),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
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
                                      decoration:
                                          AppTheme.dateDecorationShadow(),
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            color: AppTheme.white,
                                          ),
                                          Text(
                                            timeStartTemp,
                                            style: TextStyle(
                                                color: AppTheme.white,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      final DateTime pickedStart =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      print(pickedStart);
                                      setState(() {
                                        _tempTimeStart = pickedStart;
                                        timeStartTemp =
                                            formatDate.format(_tempTimeStart);
                                      });
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          color: AppTheme.white,
                                        ),
                                        Text(
                                          timeEndTemp,
                                          style: TextStyle(
                                              color: AppTheme.white,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    final DateTime pickedEnd =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    print(pickedEnd);
                                    setState(() {
                                      _tempTimeEnd = pickedEnd;
                                      timeEndTemp =
                                          formatDate.format(_tempTimeEnd);
                                    });
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

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
