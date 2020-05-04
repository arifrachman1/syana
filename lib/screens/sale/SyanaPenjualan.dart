import 'package:flutter/material.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaEcommerce.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaPenjualanMain.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaPenjualanTimhariini.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/product_rank/SyanaProductRankTerlaris.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/inventory/SyanaStokMain.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

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
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 30),
              decoration: AppTheme.tabbarDecoration(),
              child: TabBar(
                controller: tabController,
                indicatorColor: AppTheme.teal,
                unselectedLabelColor: AppTheme.teal,
                labelColor: AppTheme.teal,
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
