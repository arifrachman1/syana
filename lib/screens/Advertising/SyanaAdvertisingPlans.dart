import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaAdvertisingPlans extends StatefulWidget {
  @override
  _SyanaAdvertisingPlansState createState() => _SyanaAdvertisingPlansState();
}

class _SyanaAdvertisingPlansState extends State<SyanaAdvertisingPlans> {
  List<String> _nama = new List();

  namaItem() {
    setState(() {
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapps");
    });
  }

  @override
  void initState() {
    super.initState();
    namaItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (null),
          label: Text('Tambah Plan'),
          icon: Icon(Icons.add_circle),
          backgroundColor: AppTheme.btn_success,
        ),
        appBar: AppBar(
            title: Text("Plans"), backgroundColor: Colors.teal[700]),
        body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: <Widget>[
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
                                ],
                              ),
                            );
                          }))),
            ],
          ),
        ));
  }
}
