import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPayoutMonitoringOwner extends StatefulWidget {
  @override
  _SyanaPayoutMonitoringOwnerState createState() =>
      _SyanaPayoutMonitoringOwnerState();
}

final TextEditingController _controller = new TextEditingController();
var items = [
  'trading charter',
  'Being a lot smarter',
  'Being a self-starter',
  'Placed in charge of trading charter',
];

class _SyanaPayoutMonitoringOwnerState
    extends State<SyanaPayoutMonitoringOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Flexible(
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
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
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
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Flexible(
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        width: 350,
                        height: 450,
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
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                child: Container(
                                  child: Text(
                                    'Adi Wong',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                                child: Container(
                                  child: Text(
                                    'Gaji Harian : Rp 20.000.00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                                child: Container(
                                  child: Text(
                                    'Loyalti : Rp 1.000.00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              //button
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0, left: 20, right: 210),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: AppTheme.btn_success,
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Tambah Bonus',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //Pilih Kategori
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                                child: Container(
                                    child: TextField(
                                  autofocus: false,
                                  enableInteractiveSelection: false,
                                  // focusNode: FocusNode(),
                                  controller: _controller,
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Pilih Kategori",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    suffixIcon: PopupMenuButton<String>(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onSelected: (String value) {
                                        _controller.text = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return items.map<PopupMenuItem<String>>(
                                            (String value) {
                                          return new PopupMenuItem(
                                              child: new Text(value),
                                              value: value);
                                        }).toList();
                                      },
                                    ),
                                  ),
                                )),
                              ),
                              //Tulis Nominal
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: Container(
                                  child: TextField(
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
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
                                ),
                              ),
                              //Button Approve
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 40.0,
                                  left: 270,
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: AppTheme.btn_success,
                                  child: Text(
                                    'Approve',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
