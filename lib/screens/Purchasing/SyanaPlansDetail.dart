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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text(
          "Plans",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Tambah Plan'),
        icon: Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ), 
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Expanded(
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
                    })), 
      ),
    );
  }
}
