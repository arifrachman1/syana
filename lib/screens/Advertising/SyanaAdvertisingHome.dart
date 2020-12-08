import 'package:flutter/material.dart';
import 'package:syana/screens/Advertising/SyanaAdvertising.dart';
import 'package:syana/screens/Advertising/SyanaAdvertisingHistory.dart';
import 'package:syana/screens/Advertising/SyanaAdvertisingPlans.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaAdvertisingHome extends StatefulWidget {
  @override
  _SyanaAdvertisingHomeState createState() => _SyanaAdvertisingHomeState();
}

class _SyanaAdvertisingHomeState extends State<SyanaAdvertisingHome> {
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
                      margin: EdgeInsets.all(10.0),
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Container(
                      margin: EdgeInsets.all(13.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyanaAdvertisingPlans()),
                          );
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Plans',
                              style: TextStyle(fontSize: 25)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(13.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyanaAdvertising()),
                          );
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Advertising',
                              style: TextStyle(fontSize: 25)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(13.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyanaAdvertisingHistory()),
                          );
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('History',
                              style: TextStyle(fontSize: 25)),
                        ),
                      ),
                    ),
                  ],
                )),
              ));
  }
}
