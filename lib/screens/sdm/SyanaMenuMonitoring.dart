import 'package:flutter/material.dart';
import 'package:syana/screens/sdm/SyanaMonitoringPackaging.dart';
import 'package:syana/screens/sdm/SyanaMonitoringSales.dart';
import 'package:syana/screens/sdm/SyanaPurchasingMonitoring.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMenuMonitoring extends StatefulWidget {
  @override
  _SyanaMenuMonitoringState createState() => _SyanaMenuMonitoringState();
}

class _SyanaMenuMonitoringState extends State<SyanaMenuMonitoring> {
  bool _isLoading = false;

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: AppTheme.appBackground(),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_outlined),
                        color: Colors.white,
                        iconSize: 35,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.88,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10),
                      child: Text('Monitoring',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.09,
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: AppTheme.teal,
                        textColor: AppTheme.white,
                        child: const Text('Packaging',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SyanaMonitoringPackaging()),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.09,
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: AppTheme.teal,
                        textColor: AppTheme.white,
                        child: const Text('Sales',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyanaMonitoringSales()),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.09,
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: AppTheme.teal,
                        textColor: AppTheme.white,
                        child: const Text('Purchasing',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SyanaPurchasingMonitoring()),
                          );
                        },
                      ),
                    ),
                  ],
                )),
              ));
  }
}
