import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
                          '01-03-2020',
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
                          '31-03-2020',
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
                    child: Chart(),
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
}

// *
// *
// *
// Chart
// ================================================

class Chart extends StatefulWidget {
  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
 

  @override
  Widget build(BuildContext context) {
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
          textStyle: TextStyle(
            color: AppTheme.text_light,
            // fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          margin: 12,
          getTitles: (value) {
            switch (value.toInt()) {
              case 4:
                return 'Mar-04';
              case 8:
                return 'Mar-08';
              case 12:
                return 'Mar-12';
              case 16:
                return 'Mar-16';
              case 20:
                return 'Mar-20';
              case 24:
                return 'Mar-24';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: AppTheme.text_light,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 3:
                return '3';
              case 6:
                return '6';
              case 9:
                return '9';
              case 12:
                return '12';
              case 15:
                return '15';
            }
            return '';
          },
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

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
        FlSpot(7, 0),
        FlSpot(8, 0),
        FlSpot(9, 3),
        FlSpot(10, 0),
        FlSpot(11, 0),
        FlSpot(12, 0),
        FlSpot(13, 2),
        FlSpot(14, 0),
        FlSpot(15, 0),
        FlSpot(16, 0),
        FlSpot(17, 14),
        FlSpot(18, 0),
        FlSpot(19, 0),
        FlSpot(20, 0),
        
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
}
