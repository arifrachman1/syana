import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaHistoryDetail extends StatefulWidget {
  @override
  _SyanaHistoryDetailState createState() => _SyanaHistoryDetailState();
}

class _SyanaHistoryDetailState extends State<SyanaHistoryDetail> {
  List<String> _nama = new List();
  List<String> _tanggal = new List();

  namaItem() {
    setState(() {
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Habibie");
      _nama.add("Iksan");
      _nama.add("Tridianto");
      _nama.add("Iksan");
      _nama.add("Tridianto");
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text(
          "History",
        ),
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Expanded(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
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
                    padding: EdgeInsets.fromLTRB(8.0, 5.0, 5.0, 4.0),
                    //padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(5.0),
                    //height: 50,
                    //width: 50,
                    child: Row(
                      children: [
                        IconButton(
                          //alignment: Alignment(0, 1),
                          icon: Icon(//Icons.brightness_1,
		                          Icons.error,
                              //Icons.check_circle,
                              //Icons.av_timer,
                              color: AppTheme.btn_success),
                        ),
                        Text(
                          _nama[index],
                          style: TextStyle(fontSize: 18, color: AppTheme.white),
                        ),
                        Text(
                          ", ",
                          style: TextStyle(color: AppTheme.white),
                        ),
                        Text(
                          _tanggal[index],
                          style: TextStyle(fontSize: 18, color: AppTheme.white),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
