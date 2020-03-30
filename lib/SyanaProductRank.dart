import 'package:flutter/material.dart';
import 'package:syana/SyanaProductRankGrafikTim.dart';
import 'package:syana/SyanaProductRankTerlaris.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class ProductRank extends StatefulWidget {
  @override
  ProductRankState createState() => ProductRankState();
}

class ProductRankState extends State<ProductRank>
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
        decoration: appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: 
                  Container(
              decoration: tabbarDecoration(),
              height: 50,
              margin: EdgeInsets.only(top: 35),
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                indicatorColor: AppTheme.teal,
                unselectedLabelColor: AppTheme.teal,
                labelColor: AppTheme.teal,
                tabs: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'Terlaris',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'Grafik Tim',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 110),
                    child: Text(
                      'Grafik Global',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
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
                    GrafikTim(),
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
