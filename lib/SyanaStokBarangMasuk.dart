import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';
import 'main.dart';
import 'utils/AppTheme.dart';

class SyanaStokBarangMasuk extends StatefulWidget {
  @override
  RankState createState() => RankState();
}

class RankState extends State<SyanaStokBarangMasuk> {
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

  String selectedWaktu;
  String selectedCakupan;

  @override
  void initState() {
    selectedWaktu = waktu[6];
    selectedCakupan = cakupan[0];
  }

  void onChangedWaktu(value) {
    setState(() {
      this.selectedWaktu = value;
    });
  }

  void onChangedCakupan(value) {
    setState(() {
      this.selectedCakupan = value;
    });
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
                      decoration: inputDecorationShadow(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedWaktu,
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
                      decoration: inputDecorationShadow(),
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
              Row(
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
                            decoration: dateDecorationShadow(),
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  color: AppTheme.white,
                                ),
                                Text(
                                  dayFrom +
                                      ' - ' +
                                      monthFrom +
                                      ' - ' +
                                      yearFrom,
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
                            decoration: dateDecorationShadow(),
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
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: barangMasuk.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: listBackground(),
                  height: listHeightSmall(context),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: AppTheme.teal_light,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 63,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                getBarangMasuk(index, 0),
                                softWrap: true,
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                getBarangMasuk(index, 1) +
                                    ' | ' +
                                    getBarangMasuk(index, 2),
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
                            getBarangMasuk(index, 3).toString(),
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
