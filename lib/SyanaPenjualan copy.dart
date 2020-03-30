import 'package:flutter/material.dart';
import 'package:syana/SyanaInputresi.dart';
import 'package:syana/SyanaPenjualanMain.dart';
import 'package:syana/SyanaPenjualanTimhariini.dart';
import 'package:syana/SyanaProductRankTerlaris.dart';
import 'package:syana/SyanaStokMain.dart';
import './main.dart';

class Penjualan extends StatefulWidget {
  @override
  PenjualanState createState() => PenjualanState();
}

class PenjualanState extends State<Penjualan>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: background(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 30),
              decoration: tabbarDecoration(),
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.teal,
                unselectedLabelColor: Colors.teal[400],
                labelColor: Colors.teal[400],
                tabs: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'SEMUA',
                      style: TextStyle(fontSize: 13),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'ESSENTIAL',
                      style: TextStyle(fontSize: 13),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'Null',
                      style: TextStyle(fontSize: 13),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    PenjualanMain(),
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
