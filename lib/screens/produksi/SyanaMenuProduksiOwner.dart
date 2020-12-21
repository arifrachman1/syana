import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMenuProduksiOwner extends StatefulWidget {
  @override
  _SyanaMenuProduksiOwnerState createState() => _SyanaMenuProduksiOwnerState();
}

class _SyanaMenuProduksiOwnerState extends State<SyanaMenuProduksiOwner> {
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
                icon: Icon(Icons.arrow_back_outlined),
                color: Colors.white,
                iconSize: 40,
                onPressed: () {},
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.white,
                      size: 40.0,
                    ),
                    child: Icon(Icons.access_time),
                  ),
                )
              ]),
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
                            "Jumlah Target : 90",
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
                ],
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
                            "Mike Kwalsky",
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
                            "Status : Selesai",
                            style:
                                TextStyle(color: AppTheme.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      Container(
                        child: RaisedButton(
                          textColor: AppTheme.white,
                          onPressed: () {},
                          color: AppTheme.btn_success,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Approve",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          textColor: AppTheme.white,
                          onPressed: () {},
                          color: AppTheme.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Reject",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ]),
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
