import 'package:flutter/material.dart';
import 'package:syana/screens/produksi/SyanaTambahProduksi.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMenuProduksi extends StatefulWidget {
  @override
  _SyanaMenuProduksiState createState() => _SyanaMenuProduksiState();
}

class _SyanaMenuProduksiState extends State<SyanaMenuProduksi> {
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
                iconSize: 40.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyanaTambahProduksi()));
                },
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(13.0),
              child: RaisedButton(
                textColor: AppTheme.white,
                onPressed: () {},
                color: AppTheme.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Tambah",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.all(13.0),
              margin: EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: AppTheme.teal),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Jhon Doe",
                            style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Natuna Essential",
                            style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Jumlah Target : 80",
                            style:
                                TextStyle(color: AppTheme.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Status : Proses",
                            style:
                                TextStyle(color: AppTheme.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      textColor: AppTheme.white,
                      onPressed: () {},
                      color: AppTheme.btn_success,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Selesai",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
