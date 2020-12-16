import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPurchasingMonitoring extends StatefulWidget {
  @override
  _SyanaPurchasingMonitoringState createState() =>
      _SyanaPurchasingMonitoringState();
}

class _SyanaPurchasingMonitoringState extends State<SyanaPurchasingMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: AppTheme.appBackground(),
      child: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ],
      )),
    ));
  }
}
