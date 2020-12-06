import 'package:flutter/material.dart';
import 'package:syana/screens/Purchasing/SyanaPlansAdd.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPlans extends StatefulWidget {
  @override
  _SyanaPlansState createState() => _SyanaPlansState();
}

class _SyanaPlansState extends State<SyanaPlans> {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SyanaPlansAdd()),
            );
          },
          label: Text('Tambah Plan'),
          icon: Icon(Icons.add_circle),
          backgroundColor: AppTheme.btn_success,
        ),
        appBar: AppBar(
            title: Text("Plans"), backgroundColor: Colors.lightGreen[300]),
        body: Container(
            decoration: AppTheme.appBackground(),
            child: Expanded(
                child: Container(
                    child: ListView.builder(
                        itemCount: _nama.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //color: Colors.red,
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
                            //padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                IconButton(
                                  //alignment: Alignment(,1),
                                  icon: Icon(
                                    Icons.av_timer,
                                    color: AppTheme.btn_success,
                                  ),
                                  onPressed: () {},
                                ),
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
                              ],
                            ),
                          );
                        })))));
  }
}
