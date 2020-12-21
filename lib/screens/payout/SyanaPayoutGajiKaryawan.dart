import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPayoutGajiKaryawan extends StatefulWidget {
  @override
  _SyanaPayoutGajiKaryawanState createState() =>
      _SyanaPayoutGajiKaryawanState();
}

class _SyanaPayoutGajiKaryawanState extends State<SyanaPayoutGajiKaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 35.0,
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Payout',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Container(
                      child: SizedBox(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 5.0)),
                            Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: AppTheme.teal,
                                elevation: 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 5),
                                      child: Container(
                                        child: Text(
                                          'Grand Total Gaji',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 5, 20, 5),
                                      child: Container(
                                        child: Text(
                                          'Rp. 7.000.000',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      height: 20,
                                      thickness: 3,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 5),
                                      child: Container(
                                        child: Text(
                                          'Gaji Bulan November : Rp 3.500.00',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 5),
                                      child: Container(
                                        child: Text(
                                          'Loyalti : Rp 1.500.00',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      child: Container(
                                        child: Text(
                                          'Bonus : Rp -',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'History Pengambilan',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0)),
                            Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: AppTheme.teal,
                                elevation: 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Tanggal',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    '19/10/2020',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    '25/12/2020',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Pengambilan',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    '-Rp.1.000.000',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    '-Rp.1.000.000',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Grand Total',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    'Rp.3.000.000',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0),
                                                  ),
                                                ),
                                                Container(
                                                  // alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    'Rp.7.000.000',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            Stack(
                              fit: StackFit.loose,
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                TextField(
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Isi Nominal',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  textColor: AppTheme.white,
                                  onPressed: () {},
                                  color: AppTheme.teal,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Payout",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
