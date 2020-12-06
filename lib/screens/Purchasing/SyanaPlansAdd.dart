import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPlansAdd extends StatefulWidget {
  @override
  _SyanaPlansAddState createState() => _SyanaPlansAddState();
}

class _SyanaPlansAddState extends State<SyanaPlansAdd> {
  String _selectItem;
  List _myItem = ["Item 1", "Item 2", "Item 3", "Item 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Plan"),
          backgroundColor: Colors.lightGreen[300],
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () => debugPrint('FlatButton di tekan'),
            )
          ],
        ),
        body: Container(
          decoration: AppTheme.appBackground(),
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Select Item",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                        width: 320,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text("Select Item"),
                            value: _selectItem,
                            items: _myItem.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectItem = value;
                              });
                            },
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Jumlah Item",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Masukkan Jumlah Item",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Harga Item",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Masukkan Harga",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Total Cost",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Total Cost",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Upload Gambar",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      icon: Padding(
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, right: 10),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                      color: AppTheme.btn_success,
                      onPressed: () {},
                      label: Text(
                        "Gambar",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
