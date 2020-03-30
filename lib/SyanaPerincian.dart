import 'package:flutter/material.dart';
import 'main.dart';

class Perincian extends StatefulWidget {
  @override
  PerincianState createState() => PerincianState();
}

class PerincianState extends State<Perincian> {
  // *
  // *
  // komponen dropdown jasa pengiriman
  // ========================

  List<String> jasa = ['J&T Express', 'JNE Reguler'];

  String jasaItem = 'not-set';

  void onChangedJasa(String value) {
    setState(() {
      jasaItem = value;
    });
  }

  final int count = 6;
  List<bool> produk = List<bool>();

  @override
  void initState() {
    setState(() {
      for (var i = 0; i < this.count; i++) {
        produk.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Perincian'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: background(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: listBackground(),
                        child: Text(
                          'IRVAN SEMBARANY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  margin: EdgeInsets.only(top: 25),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        'Pilih Jasa Pengiriman',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      items: jasa.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        onChangedJasa(value);
                      },
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.only(left: 10),
                  decoration: inputDecoration(),
                  child: Text(jasaItem),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'Jual',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'Free',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: produk.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return Container(
                        alignment: Alignment.topCenter,
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  '(Better) Botanical Slimming Massage Oil',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    child: Text('Simpan'),
                    shape: roundButton(),
                    color: Colors.yellow[400],
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
