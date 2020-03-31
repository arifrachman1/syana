import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class SyanaProductRankTopFree extends StatefulWidget {
  @override
  SyanaProductRankTopFreeState createState() => SyanaProductRankTopFreeState();
}

class SyanaProductRankTopFreeState extends State<SyanaProductRankTopFree> {
  // *
  // *
  // *
  // Komponen ListView
  // ==============================================

  List<List> topFree = [
    ['Natuna Midnite Kiss Coconut Liobalm', 6037.0, '-'],
    ['Pink Rose', 2504.0, '-'],
    ['Masker Winter Sonata', 2467.0, '-'],
    ['GBC', 2375.0, '-'],
    ['CCS Ori', 2348.0, '-'],
    ['Rose Water', 1942.0, '-'],
    ["Masker Madaline's Gold Dust", 1870.0, '-'],
  ];

  getTopFree(index, index2) {
    var selectedTopFree = topFree[index];
    return selectedTopFree[index2];
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
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 190,
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
              Container(
                width: 190,
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
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: topFree.length,
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
                              getTopFree(index, 0),
                              softWrap: true,
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              getTopFree(index, 2),
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
                          getTopFree(index, 1).toString(),
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
