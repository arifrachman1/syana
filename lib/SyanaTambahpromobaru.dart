import 'package:flutter/material.dart';
import './SyanaTambahpromobaruSelanjutnya.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class Tambahpromobaru extends StatefulWidget {
  @override
  TambahState createState() => TambahState();
}

class TambahState extends State<Tambahpromobaru> {
  List<String> promo = ['Promo produk sejenis', 'Promo 2'];
  List<String> promo2 = ['Healthy Noona', 'Bunda Cerdas'];
  List<String> kategori = ['kategori 1', 'kategori 2'];

  String promoItem = 'Promo produk sejenis';
  String promo2Item = 'Healthy Noona';
  String kategoriItem = 'kategori 1';

  void onChangedPromo(String value) {
    setState(() {
      promoItem = value;
    });
  }

  void onChangedPromo2(String value) {
    setState(() {
      promo2Item = value;
    });
  }

  void onChangedKategori(String value) {
    setState(() {
      kategoriItem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: appBackground(),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding:
                EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Text(
                  'Tambahkan Promo Baru',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.text_light,
                  ),
                ),
                Container(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: inputDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: promoItem,
                      items: promo.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(
                                color: AppTheme.text_dark,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        onChangedPromo(value);
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: inputDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: promo2Item,
                      items: promo2.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(
                                color: AppTheme.text_dark,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        onChangedPromo2(value);
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: inputDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'pilih kategori',
                        style: TextStyle(
                          color: AppTheme.text_dark,
                        ),
                      ),
                      items: kategori.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(
                                color: AppTheme.text_dark,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        onChangedKategori(value);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: inputDecoration(),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: InputBorder.none,
                        hintText: ' '),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: inputDecoration(),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.0),
                      border: InputBorder.none,
                      hintText: 'Masukkan jumlah minimum',
                      hintStyle: TextStyle(
                        color: AppTheme.text_dark,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: inputDecoration(),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.0),
                      border: InputBorder.none,
                      hintText: 'Masukkan jumlah item free',
                      hintStyle: TextStyle(
                        color: AppTheme.text_dark,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ButtonTheme(
                    height: 45,
                    child: RaisedButton(
                      child: Text(
                        'SELANJUTNYA',
                        style: TextStyle(
                          color: AppTheme.text_light,
                        ),
                      ),
                      shape: roundButton(),
                      color: AppTheme.btn_success,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return TambahpromobaruSelanjutnya();
                            },
                          ),
                        );
                      },
                    ),
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
