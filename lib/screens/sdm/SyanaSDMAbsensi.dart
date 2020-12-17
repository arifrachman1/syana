import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaSDMAbsensi extends StatefulWidget {
  @override
  _SyanaSDMAbsensiState createState() => _SyanaSDMAbsensiState();
}

class _SyanaSDMAbsensiState extends State<SyanaSDMAbsensi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 35.0,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5.0)),
              Container(
                //color: AppTheme.white,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  bottom: 15,
                  top: 15,
                ),
                child: Text(
                  "Absensi",
                  style: TextStyle(
                      fontSize: 30,
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Cari karyawan...",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        margin: EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/papuma.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.all(7.0),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Jon Doe",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Absen pada jam 08:30",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Status : Aman",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.check,
                                  size: 25.0, color: AppTheme.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 8, 0),
                        margin: EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/papuma.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.all(7.0),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Nina Choi",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Absen pada jam 20:30",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Status : Aman",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.check,
                                  size: 25.0, color: AppTheme.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 8, 0),
                        margin: EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/papuma.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.all(7.0),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Alex King",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Belum Absen",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Status : ",
                                      style: TextStyle(color: AppTheme.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.dangerous,
                                  size: 25.0, color: AppTheme.white),
                            )
                          ],
                        ),
                      )
                    ]),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
