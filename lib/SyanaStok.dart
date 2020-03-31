import 'package:flutter/material.dart';
import 'package:syana/SyanaInputresi.dart';
import 'package:syana/SyanaProductRankTerlaris.dart';
import 'package:syana/SyanaStokMain.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class Stok extends StatefulWidget {
  @override
  StokState createState() => StokState();
}

class StokState extends State<Stok> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: tabbarDecoration(),
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: AppTheme.teal,
                      unselectedLabelColor: AppTheme.teal,
                      labelColor: AppTheme.teal,
                      tabs: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxWidth: 110),
                          child: Text(
                            'Barang Masuk',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 110),
                          child: Text(
                            'Stok',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 110),
                          child: Text(
                            'Barang Keluar',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    SyanaProductRankTerlaris(),
                    StokMain(),
                    SyanaProductRankTerlaris(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
