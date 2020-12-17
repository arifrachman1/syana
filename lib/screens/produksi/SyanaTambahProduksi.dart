import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaTambahProduksi extends StatefulWidget {
  @override
  _SyanaTambahProduksiState createState() => _SyanaTambahProduksiState();
}

class _SyanaTambahProduksiState extends State<SyanaTambahProduksi> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 35.0,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
              //color: AppTheme.white,
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "Produksi",
                style: TextStyle(
                  fontSize: 30,
                  color: AppTheme.white,
                ),
              ),
            ),
            DropdownButtonHideUnderline(
                child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppTheme.white),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: DropdownButton(
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Produk 1"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Produk 2"),
                      value: 2,
                    ),
                    DropdownMenuItem(child: Text("Produk 3"), value: 3),
                    DropdownMenuItem(child: Text("Produk 4"), value: 4)
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
            )),
            Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Jumlah Target",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(18.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(18.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                textColor: AppTheme.white,
                onPressed: () {},
                color: AppTheme.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Ajukan",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
