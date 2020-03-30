import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class SyanaProductRankTerlaris extends StatefulWidget {
  @override
  RankState createState() => RankState();
}

class RankState extends State<SyanaProductRankTerlaris> {
  // *
  // *
  // *
  // Komponen ListView
  // ==============================================

  List<List> terlaris = [
    ['GBC', 12021.0],
    ['Methi', 4999.0],
    ['Cough and Flu EO Blend', 4841.0],
    ['Pink Rose', 4841.0],
    ['Himalayan Pink Salt', 4841.0],
    ['Lavender EO', 3790.0],
    ['Cleanser 100ml', 3555.0],
  ];

  getTerlaris(index, index2) {
    var selectedTerlaris = terlaris[index];
    return selectedTerlaris[index2];
  }

  // *
  // *
  // Komponen Dropdown button
  // ===========================================
  List<String> total = ['Grand Total', 'Total'];
  List<String> cakupan = ['Global', 'Lokal'];

  String totalItem = 'Grand Total';
  String cakupanItem = 'Global';

  void onChangedTotal(value) {
    setState(() {
      this.totalItem = value;
    });
  }

  void onChangedCakupan(value) {
    setState(() {
      this.cakupanItem = value;
    });
  }

  // ============================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.only(top: 50),
          child: ListView.builder(
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
                      child: Text(
                        getTerlaris(index, 0),
                        softWrap: true,
                        style: TextStyle(
                          color: AppTheme.text_light,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
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
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 190,
                padding: EdgeInsets.only(left: 10),
                decoration: inputDecorationShadow(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: totalItem,
                    items: total.map(
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
                      onChangedTotal(value);
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
                    value: cakupanItem,
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
      ],
    );
  }
}
