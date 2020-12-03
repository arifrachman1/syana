import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPlansDetail extends StatefulWidget {
  @override
  _SyanaPlansDetailState createState() => _SyanaPlansDetailState();
}

class _SyanaPlansDetailState extends State<SyanaPlansDetail> {
  List<String> _nama = new List();

  namaItem() {
    setState(() {
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
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
        body: Container(
      decoration: AppTheme.appBackground(),
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(15.0),
            child: Text("Plans",
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
                      }))),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.12,
            child: Center(
              child: RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: EdgeInsets.all(0.0),
                shape: StadiumBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.green[300],
                  ),
                  child: Text(
                    'Tambah Plan',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
