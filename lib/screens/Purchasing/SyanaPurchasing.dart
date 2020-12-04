import 'package:flutter/material.dart';
import 'package:syana/screens/Purchasing/SyanaHistoryDetail.dart';
import 'package:syana/screens/Purchasing/SyanaPlans.dart';
import 'package:syana/screens/Purchasing/SyanaPurchasingDetail.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPurchasing extends StatefulWidget {
  @override
  _SyanaPurchasingState createState() => _SyanaPurchasingState();
}

class _SyanaPurchasingState extends State<SyanaPurchasing> {
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
                                builder: (context) => SyanaPlans()),
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
                                builder: (context) => SyanaPurchasingDetail()),
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
                          child: const Text('Purchasing',
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
                                builder: (context) => SyanaHistoryDetail()),
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
