import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaAdvertisingHistoryDetail extends StatefulWidget {
  @override
  _SyanaAdvertisingHistoryDetailState createState() =>
      _SyanaAdvertisingHistoryDetailState();
}

class _SyanaAdvertisingHistoryDetailState
    extends State<SyanaAdvertisingHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text("Natuna Essential"),
      ),
      body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  ),
                ),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/suket.jpg'),
                              fit: BoxFit.fill),
                          shape: BoxShape.rectangle),
                    ),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width * 0.57,
                        height: MediaQuery.of(context).size.height * 0.16,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.all(3.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Natuna Essential",
                              style: TextStyle(
                                  fontSize: 25, color: AppTheme.text_darker),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "10 Pcs",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Rp. 50.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.text_dark),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Approved/Reject By : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme.text_dark,
                                    ),
                                  ),
                                  Text(
                                    "Owner",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppTheme.text_darker),
                                  ),
                                ],
                              )),
                        ])),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.15,
                        alignment: Alignment.topRight,
                        child: Icon(Icons.check_circle,
                            size: 30.0, color: Colors.blue))
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Gambar",
                  )),
              Container(
                alignment: Alignment.bottomLeft,
                child: Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/suket.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/suket.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/suket.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/suket.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                      ],
                    )
                  ],
                )),
              )
            ],
          )),
    );
  }
}
