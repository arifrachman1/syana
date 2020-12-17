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
      // appBar: AppBar(
      //   leading: BackButton(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35.0,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 25.0)),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Purchasing',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Cari karyawan...",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Flexible(
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    children: <Widget>[
                      ListTile(
                        title: Text('Jhon Doe',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Absen Pada Jam 08:23',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Nina Choi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Absen Pada Jam 08:49',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Nina Choi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Absen Pada Jam 08:49',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Nina Choi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Absen Pada Jam 08:49',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Nina Choi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Absen Pada Jam 08:49',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Alex King',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Belum Absen',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Alex King',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Belum Absen',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Alex King',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Belum Absen',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Alex King',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text('Belum Absen',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
