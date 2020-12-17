import 'package:flutter/material.dart';
import 'package:syana/screens/sdm/SyanaMenuMonitoring.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMonitoringPackaging extends StatefulWidget {
  @override
  _SyanaMonitoringPackagingState createState() =>
      _SyanaMonitoringPackagingState();
}

class _SyanaMonitoringPackagingState extends State<SyanaMonitoringPackaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 25.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.05,
                // ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SyanaMenuMonitoring()),
                      );
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.88,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 15, right: 10),
                  child: Text('Packaging',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "cari karyawan",
                      contentPadding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(18.0)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('John Doe',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0)),
                            subtitle: Text('Jumlah Transaksi Order : 45',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                )),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          ListTile(
                            title: Text('Nina Choi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0)),
                            subtitle: Text('Jumlah Transaksi Order : 80',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                )),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          ListTile(
                            title: Text('Alex King',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0)),
                            subtitle: Text('Jumlah Transaksi Order : 20',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                )),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}
