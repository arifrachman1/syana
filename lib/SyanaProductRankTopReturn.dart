import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class SyanaProductRankTopReturn extends StatefulWidget {
  @override
  SyanaProductRankTopReturnState createState() => SyanaProductRankTopReturnState();
}

class SyanaProductRankTopReturnState extends State<SyanaProductRankTopReturn> {
  // *
  // *
  // *
  // Komponen ListView
  // ==============================================

  List<List> terlaris = [
    ['GBC', 12021.0, '-'],
    ['Methi', 4999.0, '-'],
    ['Cough and Flu EO Blend', 4841.0, '-'],
    ['Pink Rose', 4841.0, '-'],
    ['Himalayan Pink Salt', 4841.0, '-'],
    ['Lavender EO', 3790.0, '-'],
    ['Cleanser 100ml', 3555.0, '-'],
  ];

  getTerlaris(index, index2) {
    var selectedTerlaris = terlaris[index];
    return selectedTerlaris[index2];
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
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
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: terlaris.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: listBackground(),
                  height: 80,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: 40,
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 70,
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: AppTheme.teal_light,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              getTerlaris(index, 0),
                              softWrap: true,
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              getTerlaris(index, 2),
                              softWrap: true,
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        child: Text(
                          getTerlaris(index, 1).toString(),
                          softWrap: true,
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 14,
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
