import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ChartDataModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

String selectedPromo;
int selectedGrafik = 0;

class GrafikGlobal extends StatefulWidget {
  @override
  GrafikGlobalState createState() => GrafikGlobalState();
}

class GrafikGlobalState extends State<GrafikGlobal> {
  int totalProdukTerjual = 19;
  DateFormat formatDate = DateFormat("yyyy-MM-dd");
  DateTime timeStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime timeEnd = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  String _currentTimeStart;
  String _currentTimeEnd;

  //Build Chart

  LineChartData chart() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          print(touchResponse);
        },
        handleBuiltInTouches: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 10,
          textStyle: TextStyle(
            color: AppTheme.text_light,
            // fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          margin: 12,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: AppTheme.text_light,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          interval: 5,
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: AppTheme.white,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 31,
      maxY: 17,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }
  LineChartBarData lineChartBarData1;
  linesBarData1() {
    lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(13, 2),
        FlSpot(14, 0),
        FlSpot(15, 0),
        FlSpot(16, 0),
        FlSpot(17, 14),
        FlSpot(18, 0),
        FlSpot(19, 0),
        FlSpot(30, 0),
      ],
      isCurved: false,
      colors: [
        Colors.yellow,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true, dotColor: Colors.yellow),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1,
    ];
  }

  // API Implementation

  SaleController _saleController;
  bool _isLoading = false;
  List<ChartDataModel> chartGlobal = new List();

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
    initDataChart();
  }

  initDataChart() async {
    setLoadingState();
    await _saleController.getChartDataGlobal(context, setLoadingState, setData,
        "1", "1", _currentTimeStart, _currentTimeEnd);
    print("list length : " + chartGlobal.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is List<ChartDataModel> && data.isNotEmpty) {
      setState(() {
        chartGlobal = data;
        for(int i=0;i<chartGlobal.length;i++){
          lineChartBarData1.spots.add(FlSpot(1,double.parse(chartGlobal[i].chartValue)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    height: Dimens.grafikHeight(context),
                    child: buildChart(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          totalProdukTerjual.toString(),
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Produk Terjual',
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
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return null;
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              AppTheme.teal,
              AppTheme.teal_light,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: LineChart(
                    chart(),
                    swapAnimationDuration: Duration(milliseconds: 400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
