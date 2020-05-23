import 'package:flutter/material.dart';
import 'package:syana/screens/inventory/SyanaStockExt.dart';
import 'package:syana/screens/inventory/SyanaStockIn.dart';
import 'package:syana/screens/inventory/SyanaStokMain.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

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
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: AppTheme.tabbarDecoration(),
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: AppTheme.teal,
                      unselectedLabelColor: AppTheme.teal,
                      labelColor: AppTheme.teal,
                      tabs: <Widget>[
                        Container(
                          child: Text(
                            'Barang Masuk',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Stok',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
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
                    SyanaStockIn(),
                    StokMain(),
                    SyanaStokBarangKeluar(),
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
