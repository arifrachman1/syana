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
  List<String> tim = ['Healthy Noona', 'Bunda Cerdas'];
  List<String> kategori = ['kategori 1', 'kategori 2'];

  String selectedPromo;
  String selectedTim;
  String selectedKategori;

  void onChangedPromo(String value) {
    setState(() {
      selectedPromo = value;
    });
  }

  void onChangedTim(String value) {
    setState(() {
      selectedTim = value;
    });
  }

  void onChangedKategori(String value) {
    setState(() {
      selectedKategori = value;
    });
  }

  @override
  void initState() {
    selectedPromo = promo[0];
    selectedTim = tim[0];
    // selectedKategori = kategori[0];
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
                      value: selectedPromo,
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
                      value: selectedTim,
                      items: tim.map(
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
                        onChangedTim(value);
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
                      value: selectedKategori,
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
                  child: Container(
                    width: buttonWidthWide(context),
                    child: AspectRatio(
                      aspectRatio: buttonRatioWide(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
