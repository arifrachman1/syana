import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMonitoringSales extends StatefulWidget {
  @override
  _SyanaMonitoringSalesState createState() => _SyanaMonitoringSalesState();
}

class _SyanaMonitoringSalesState extends State<SyanaMonitoringSales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
          child: Expanded(
            child: ListView(
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Container(
                  child: Text('Sales', style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold
                  )),
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "Cari karyawan...",
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('John Doe', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Jumlah Transaksi Order: 45', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Nina Choi', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Jumlah Transaksi Order: 80', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Alex King', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Jumlah Transaksi Order: 20', style: TextStyle(
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
            )
          ),
        ),
      ),
    );
  }
}