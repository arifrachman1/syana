import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaHistoryDetail extends StatefulWidget {
  @override
  _SyanaHistoryDetailState createState() => _SyanaHistoryDetailState();
}

class _SyanaHistoryDetailState extends State<SyanaHistoryDetail> {
  List<String> _icon = new List();
  List<String> _nama = new List();
  List<String> _tanggal = new List();
  //Centang
  //Silang
  //Menunggu
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
    });
  }

  tanggalItem() {
    setState(() {
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
      _tanggal.add("22 Januari 2021");
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
        body: Container(
      decoration: AppTheme.appBackground(),
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(15.0),
            child: Text("History",
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 40,
                  )),
          ),
          Flexible(
              child: Container(
                  child: ListView.builder(
                      itemCount: _nama.length,
                      itemBuilder: (context, index) {
                        return Container(
                          //color: Colors.red,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1.0, color: Colors.white),
                              ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(7.0),
                          //height: 50,
                          //width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                //alignment: Alignment(,1),
                                icon: Icon(
                                  Icons.brightness_1,
                                  color: AppTheme.btn_success
                                ),
                              ),
                              Text(
                                _nama[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.white
                                ),
                              ),
                              Text(
                                ", ",
                                style: TextStyle(
                                  color: AppTheme.white
                                ),
                              ),
                              Text(
                                _tanggal[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.white
                                ),
                              )
                            ],
                          ),
                        );
                      })))
        ],
      ),
    ));
  }
}