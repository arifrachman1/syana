import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class CreatePurchasingDetail extends StatefulWidget {
  @override
  _CreatePurchasingDetailState createState() => _CreatePurchasingDetailState();
}

class _CreatePurchasingDetailState extends State<CreatePurchasingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      //color: AppTheme.white,
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/papuma.jpg'),
                              fit: BoxFit.fill),
                          shape: BoxShape.rectangle),
                    ),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        //color: AppTheme.red,
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
                                  fontSize: 25, color: AppTheme.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Jumlah 10 Pcs",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Harga Item : Rp. 50.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Jumlah Cost : Rp. 55.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Tanggal Pengajuan : 01 Januari 2021",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
                            ),
                          ),
                          //Padding(padding: EdgeInsets.all(25)),
                        ]))
                  ],
                ),
              ),
              Container(
                  //color: Colors.blue,
                  alignment: Alignment.topRight,
                  child: Container(
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
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
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
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
