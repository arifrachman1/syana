import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPayoutGajiOwner extends StatefulWidget {
  @override
  _SyanaPayoutGajiOwnerState createState() => _SyanaPayoutGajiOwnerState();
}

class _SyanaPayoutGajiOwnerState extends State<SyanaPayoutGajiOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 40.0,
                        color: Colors.white,
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Container(
                  child: Text('Payout', style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold
                  )),
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "cari karyawan",
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('John Doe', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 3.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Adi Wong', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Clara', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('John Doe', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 3.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Adi Wong', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Clara', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('John Doe', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 3.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Adi Wong', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      ListTile(
                        title: Text('Clara', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        )),
                        subtitle: Text('Gaji Harian : Rp 2.000.000', style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}