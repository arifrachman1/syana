import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaAdvertisingDetail extends StatefulWidget {
  @override
  _SyanaAdvertisingDetailState createState() => _SyanaAdvertisingDetailState();
}

class _SyanaAdvertisingDetailState extends State<SyanaAdvertisingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text(
          "Natuna Essential",
          style: TextStyle(color: AppTheme.white),
        ),
      ),
      body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.23,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/mountain.jpg'),
                              fit: BoxFit.fill),
                          shape: BoxShape.rectangle),
                    ),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.all(3.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Natuna Essential",
                              style: TextStyle(
                                  fontSize: 20, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Jumlah 10 Pcs",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Harga Item : Rp. 50.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Jumlah Cost : Rp. 55.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Tanggal Pengajuan : 01 Januari 2021",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {},
                            color: AppTheme.btn_success,
                            textColor: AppTheme.white,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 15.0,
                                ),
                                Text(" Approve")
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {},
                            color: AppTheme.red,
                            textColor: AppTheme.white,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.dangerous,
                                  size: 15.0,
                                ),
                                Text(" Reject")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
