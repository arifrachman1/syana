import 'package:flutter/material.dart';
import 'package:syana/SyanaAkunAbout.dart';
import 'package:syana/SyanaAkunProfil.dart';
import 'package:syana/SyanaAkunTrip.dart';
import 'package:syana/SyanaAkunMyPoints.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class SyanaAkun extends StatefulWidget {
  @override
  SyanaAkunState createState() => SyanaAkunState();
}

class SyanaAkunState extends State<SyanaAkun>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 1,
    );
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
                          child: Text(
                            'About Syana',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Profil',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Syana Trip',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Text(
                            'My Points',
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
                margin: EdgeInsets.only(top: 10),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    SyanaAkunAbout(),
                    SyanaAkunProfil(),
                    SyanaAkunTrip(),
                    SyanaAkunMyPoints(),
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
