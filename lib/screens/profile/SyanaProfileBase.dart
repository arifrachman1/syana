import 'package:flutter/material.dart';
import 'package:syana/screens/profile/SyanaAkunAbout.dart';
import 'package:syana/screens/profile/SyanaMyPoints.dart';
import 'package:syana/screens/profile/SyanaProfile.dart';
import 'package:syana/screens/profile/SyanaTrips.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

class SyanaProfileBase extends StatefulWidget {
  @override
  SyanaProfileBaseState createState() => SyanaProfileBaseState();
}

class SyanaProfileBaseState extends State<SyanaProfileBase>
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
                    SyanaProfile(),
                    SyanaTrips(),
                    SyanaMyPoints(),
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
