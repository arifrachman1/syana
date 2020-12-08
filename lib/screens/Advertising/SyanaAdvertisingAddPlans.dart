import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import 'package:image/image.dart' as imgLib;

class SyanaAdvertisingAddPlans extends StatefulWidget {
  @override
  _SyanaAdvertisingAddPlansState createState() =>
      _SyanaAdvertisingAddPlansState();
}

class _SyanaAdvertisingAddPlansState extends State<SyanaAdvertisingAddPlans> {
  @override
  void initState() {
    super.initState();
  }

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
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Row(children: [
                    Text(
                      "Select Produk",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ])),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: TextField(
                      //controller: ,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Select Produk",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                      child: Row(children: [
                    Text(
                      "Nama Advertising",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ])),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: TextField(
                      //controller: ,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Masukkan Nama",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                      child: Row(children: [
                    Text(
                      "Deskripsi",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ])),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: TextFormField(
                      //controller: ,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Deskripsi",
                        fillColor: Colors.white,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Container(
                      child: Row(children: [
                    Text(
                      "Upload Gambar",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ])),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff5DB075),
                    child: MaterialButton(
                      minWidth: 100.0,
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {},
                      child: Text(
                        "Gambar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
