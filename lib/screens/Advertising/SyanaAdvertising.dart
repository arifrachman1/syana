import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaAdvertising extends StatefulWidget {
  @override
  _SyanaAdvertisingState createState() => _SyanaAdvertisingState();
}

class _SyanaAdvertisingState extends State<SyanaAdvertising> {
  List<String> _icon = new List();
  List<String> _nama = new List();
  List<String> _tanggal = new List();
  
  iconItem() {
    setState(() {
      _icon.add("dangerous");
      _icon.add("check");
      _icon.add("av_timer");
    });
  }

  namaItem() {
    setState(() {
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksans");
    });
  }

  tanggalItem() {
    setState(() {
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2020");
    });
  }

  @override
  void initState() {
    super.initState();
    namaItem();
    tanggalItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text(
          "Advertising",
        ),
      ),
      body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Flexible(
                  child: Container(
                      child: ListView.builder(
                          itemCount: _nama.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.0,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(8.0, 5.0, 5.0, 4.0),
                              margin: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        //Icons.dangerous,
                                        //Icons.check_circle,
                                        Icons.av_timer,
                                        color: AppTheme.btn_success,
                                      ),
                                      onPressed: (null)),
                                  Text(
                                    _nama[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    ", ",
                                    style: TextStyle(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    _tanggal[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          })))
            ],
          )),
    );
  }
}
