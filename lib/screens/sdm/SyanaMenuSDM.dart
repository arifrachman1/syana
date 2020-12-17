import 'package:flutter/material.dart';
import 'package:syana/screens/sdm/SyanaMenuMonitoring.dart';
import 'package:syana/screens/sdm/SyanaSDMAbsensi.dart';

import '../../utils/AppTheme.dart';

class SyanaMenuSDM extends StatefulWidget {
  @override
  _SyanaMenuSDMState createState() => _SyanaMenuSDMState();
}

class _SyanaMenuSDMState extends State<SyanaMenuSDM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 40.0,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('SUMBER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('DAYA',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('MANUSIA',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold))),
                  ],
                )),
            Padding(padding: EdgeInsets.only(top: 25.0)),
            Container(
              margin: EdgeInsets.all(13.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SyanaSDMAbsensi()),
                  );
                },
                color: AppTheme.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Absensi', style: TextStyle(fontSize: 25)),
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
                        builder: (context) => SyanaMenuMonitoring()),
                  );
                },
                color: AppTheme.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: const EdgeInsets.all(10.0),
                  child:
                      const Text('Monitoring', style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
