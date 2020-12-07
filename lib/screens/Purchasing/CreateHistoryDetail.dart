import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class CreateHistoryDetail extends StatefulWidget {
  @override
  _CreateHistoryDetailState createState() => _CreateHistoryDetailState();
}

class _CreateHistoryDetailState extends State<CreateHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      //color: AppTheme.white,
                      //alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.14,
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
                        width: MediaQuery.of(context).size.width * 0.57,
                        height: MediaQuery.of(context).size.height * 0.16,
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
                              "10 Pcs",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Rp. 50.000,00",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.white),
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
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    "Admin",
                                    style: TextStyle(
                                        fontSize: 15, color: AppTheme.white),
                                  ),
                                ],
                              )),

                          //Padding(padding: EdgeInsets.all(25)),
                        ])),
                    Container(
                        //color: Colors.red,

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
                  //color: Colors.blue,
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
                          //alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/city.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          //alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/flower.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          //alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/mountain.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.rectangle),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          //alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/papuma.jpg'),
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
