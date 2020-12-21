import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaMenuHistoryProduksiOwner extends StatefulWidget {
  @override
  _SyanaMenuHistoryProduksiOwnerState createState() =>
      _SyanaMenuHistoryProduksiOwnerState();
}

class _SyanaMenuHistoryProduksiOwnerState
    extends State<SyanaMenuHistoryProduksiOwner> {
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
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                bottom: 15,
                top: 15,
              ),
              child: Text(
                "History Produksi",
                style: TextStyle(
                  fontSize: 30,
                  color: AppTheme.white,
                  fontWeight: FontWeight.bold
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
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Hana Li",
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
                            "Jumlah Target : 30",
                            style:
                                TextStyle(color: AppTheme.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Status : selesai",
                            style:
                                TextStyle(color: AppTheme.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(bottom: 55),
                    child: Text(
                      "Tanggal : 18-12-2020",
                      style: TextStyle(color: AppTheme.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
