import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'main.dart';

String selectedProduk;
int selectedGrafik = 0;

class GrafikProduk extends StatefulWidget {
  @override
  GrafikProdukState createState() => GrafikProdukState();
}

class GrafikProdukState extends State<GrafikProduk> {

  int totalProdukTerjual = 1329;

  List<String> produk = [
    '(Natuna) Tea Tree Essential',
    '(Hotter) Botanical Slimming Massage Oil Carolina',
  ];

  void onChangedPromo(String value) {
    setState(() {
      selectedProduk = value;
      selectedGrafik = produk.indexOf(value);
    });
  }

  @override
  void initState() {
    selectedProduk = produk[0];
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
                    decoration: listBackground(),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10,),
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
                          '07-08-2019',
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
                          '13-03-2020',
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 13, right: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pilih Tim',
                      style: TextStyle(
                        color: AppTheme.text_light,
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 13, right: 15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        iconEnabledColor: AppTheme.white,
                        hint: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            selectedProduk,
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 14,
                            ),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        items: produk.map(
                          (String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  val,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String value) {
                          onChangedPromo(value);
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    height: grafikHeight(context),
                    child: Chart(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,),
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
  // int showData = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   isShowingMainData = true;
  // }

  showChart(int value) {
    switch (value) {
      case 0:
        return chart1();
      case 1:
        return chart2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.15,
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
          padding: EdgeInsets.only(left: 10, right: 10,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              Text(
                'Penjualan',
                style: TextStyle(
                  color: AppTheme.text_light,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                selectedProduk,
                style: TextStyle(
                    color: AppTheme.text_light,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: LineChart(
                    showChart(selectedGrafik),
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

  LineChartData chart1() {
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
            fontWeight: FontWeight.bold,
            fontSize: 9,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'Aug-08';
              case 3:
                return 'Sep-11';
              case 6:
                return 'Oct-16';
              case 9:
                return 'Nov-20';
              case 12:
                return 'Dec-24';
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
              case 1:
                return '0';
              case 3:
                return '200';
              case 5:
                return '400';
              case 7:
                return '600';
              case 9:
                return '800';
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
      maxX: 15,
      maxY: 10,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(0, 1),
        FlSpot(0.2, 1.5),
        FlSpot(0.4, 4),
        FlSpot(0.6, 2),
        FlSpot(0.8, 2),
        FlSpot(1, 2.2),
        FlSpot(1.2, 8),
        FlSpot(1.4, 6),
        FlSpot(1.6, 2),
        FlSpot(1.8, 9),
        FlSpot(2, 1.8),
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

  LineChartData chart2() {
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
            fontWeight: FontWeight.bold,
            fontSize: 7,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'Aug-08';
              case 3:
                return 'Sep-11';
              case 6:
                return 'Oct-16';
              case 9:
                return 'Nov-20';
              case 12:
                return 'Dec-24';
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
              case 1:
                return '0';
              case 3:
                return '200';
              case 5:
                return '400';
              case 7:
                return '600';
              case 9:
                return '800';
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
      maxX: 15,
      maxY: 10,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    LineChartBarData lineChartBarData2 = const LineChartBarData(
      spots: [
        FlSpot(0, 9),
        FlSpot(0.2, 1.5),
        FlSpot(0.4, 4),
        FlSpot(0.6, 7),
        FlSpot(0.8, 4),
        FlSpot(1, 3),
        FlSpot(1.2, 8),
        FlSpot(1.4, 6),
        FlSpot(1.6, 7),
        FlSpot(1.8, 9),
        FlSpot(2, 1.8),
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
      lineChartBarData2,
    ];
  }
}
